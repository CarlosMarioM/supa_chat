GITHUB_USER := carlosmariom
BASE_HREF := /$(OUTPUT)/
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
GITHUB_REPO = https://github.com/$(GITHUB_USER)/$(OUTPUT)

deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=repo_name)
endif

	@echo "🚀 Starting deployment..."
	
	# Build with conditional Supabase flags
	@echo "🛠️ Building web app..."
	@flutter build web \
		--release \
		--base-href /$(OUTPUT)/ \
		$(if $(SUPABASE_URL),--dart-define=SUPABASE_URL='$(SUPABASE_URL)') \
		$(if $(SUPABASE_ANON_KEY),--dart-define=SUPABASE_ANON_KEY='$(SUPABASE_ANON_KEY)') \
		--no-tree-shake-icons

	@echo "📡 Deploying to GitHub Pages..."
	@cd build/web && \
	git init && \
  git config user.email "actions@github.com" && \
	git config user.name "GitHub Actions" && \
	git add . && \
	git commit -m "Deploy v$(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Successfully deployed!"
	@echo "🌐 Live at: https://$(GITHUB_USER).github.io/$(OUTPUT)/"

	@echo "✅ Build complete!"
	@echo "🌐 Preview: file://$(PWD)/build/web/index.html"

.PHONY: deploy
