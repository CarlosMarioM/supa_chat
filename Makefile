# Makefile for Flutter Web Deployment
# Usage: make deploy OUTPUT=repo_name GITHUB_TOKEN=your_token

# Configuration
GITHUB_USER := carlosmariom
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)
BASE_HREF := /$(OUTPUT)/
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

on:
     push:
       branches: [ master ]

   jobs:
    build:
      runs-on: ubuntu-latest
      steps:
      - name: checkout repo
        uses: actions/checkout@main
      - name: build application
        run: make deploy OUTPUT=supa_chat

# Deployment target
deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=repo_name [GITHUB_TOKEN=token])
endif

	@echo "🚀 Starting deployment to $(OUTPUT)..."
	
	# Build phase
	@echo "🧹 Cleaning project..."
	@flutter clean
	
	@echo "📦 Getting packages..."
	@flutter pub get
	
	@echo "🛠️ Building web app..."
	@flutter build web \
		--release \
		--base-href $(BASE_HREF) \
		$(if $(SUPABASE_URL),--dart-define=SUPABASE_URL=$(SUPABASE_URL)) \
		$(if $(SUPABASE_ANON_KEY),--dart-define=SUPABASE_ANON_KEY=$(SUPABASE_ANON_KEY)) \
		--no-tree-shake-icons

	# Deployment phase
	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Successfully deployed!"
	@echo "🌐 Live at: https://$(GITHUB_USER).github.io/$(OUTPUT)/"
	@echo "⏳ Allow 1-2 minutes for GitHub Pages to update"

.PHONY: deploy