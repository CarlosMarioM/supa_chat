GITHUB_USER := carlosmariom
BASE_HREF := /$(OUTPUT)/
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')
GITHUB_REPO := https://github.com/$(GITHUB_USER)/$(OUTPUT)

deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=repo_name)
endif

	@echo "🚀 Starting deployment..."
	
	@echo "🛠️ Validating keys"
	@echo "🛠️ SUPABASE_URL: $(SUPABASE_URL)"
	@echo "🛠️ SUPABASE_ANON_KEY: $(SUPABASE_ANON_KEY)"
  
	@echo "🛠️ Building web app..."
	@flutter build web \
		--release \
		--base-href $(BASE_HREF) \
		$(if $(SUPABASE_URL),--dart-define=SUPABASE_URL='$(SUPABASE_URL)') \
		$(if $(SUPABASE_ANON_KEY),--dart-define=SUPABASE_ANON_KEY='$(SUPABASE_ANON_KEY)') \
		--no-tree-shake-icons

	@echo "📡 Deploying to GitHub Pages..."
	@cd build/web && \
	git init && \
	git checkout -b main && \
	git add . && \
	git commit -m "Deploy v$(BUILD_VERSION)" && \
	if git remote get-url origin >/dev/null 2>&1; then \
		git remote set-url origin https://$(GITHUB_TOKEN)@github.com/$(GITHUB_USER)/$(OUTPUT).git; \
	else \
		git remote add origin https://$(GITHUB_TOKEN)@github.com/$(GITHUB_USER)/$(OUTPUT).git; \
	fi && \
	git push -u -f origin main || \
	(echo "⚠️ Failed to push with token, trying SSH..." && \
	git remote set-url origin git@github.com:$(GITHUB_USER)/$(OUTPUT).git && \
	git push -u -f origin main)

	@echo "✅ Successfully deployed!"
	@echo "🌐 Live at: https://$(GITHUB_USER).github.io/$(OUTPUT)/"
	@echo "📦 Build version: v$(BUILD_VERSION)"
	@echo "🔍 Preview: file://$(PWD)/build/web/index.html"

.PHONY: deploy