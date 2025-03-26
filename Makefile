# Makefile for deploying Flutter web projects to GitHub Pages with Supabase

# Configuration
GITHUB_USER = carlosmariom
OUTPUT ?= supa_chat  # Default repo name
BASE_HREF = /$(OUTPUT)/
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
SUPABASE_URL ?= $(error SUPABASE_URL is not set)
SUPABASE_ANON_KEY ?= $(error SUPABASE_ANON_KEY is not set)

# Main deployment target
deploy: clean get-deps build-web push-to-gh-pages

# Clean the project
clean:
	@echo "🚧 Cleaning project..."
	flutter clean

# Get dependencies
get-deps:
	@echo "📦 Getting packages..."
	flutter pub get

# Build for web with secrets
build-web:
	@echo "🛠️ Building for web with secrets..."
	flutter build web \
		--release \
		--base-href $(BASE_HREF) \
		--dart-define=SUPABASE_URL=$(SUPABASE_URL) \
		--dart-define=SUPABASE_ANON_KEY=$(SUPABASE_ANON_KEY) \
		--web-renderer html \
		--no-tree-shake-icons

# Deploy to GitHub Pages branch
push-to-gh-pages:
	@echo "🚀 Deploying to GitHub Pages..."
	cd build/web && \
	git init && \
	git checkout -b gh-pages && \
	git add -A && \
	git commit -m "Deploy v$(BUILD_VERSION)" && \
	git remote add origin https://github.com/$(GITHUB_USER)/$(OUTPUT).git && \
	git push -f origin gh-pages
	@echo "✅ Successfully deployed!"
	@echo "🌐 Open: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

# Local development server
run:
	flutter run -d chrome \
		--dart-define=SUPABASE_URL=$(SUPABASE_URL) \
		--dart-define=SUPABASE_ANON_KEY=$(SUPABASE_ANON_KEY) \
		--web-renderer html

.PHONY: deploy clean get-deps build-web push-to-gh-pages run