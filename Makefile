.PHONY: dev build preview lint format test clean deploy docker-build docker-run help

# Development
dev: ## Start development server
	pnpm dev

build: ## Build for production
	pnpm build

preview: ## Preview production build locally
	pnpm build && pnpm preview

# Quality
lint: ## Run ESLint
	pnpm lint

lint-fix: ## Fix ESLint issues
	pnpm lint:fix

format: ## Format code with Prettier
	pnpm format

format-check: ## Check code formatting
	pnpm format:check

type-check: ## Run TypeScript type checking
	pnpm type-check

check: lint format-check type-check ## Run all quality checks
	@echo "✅ All quality checks passed!"

# Docker
docker-build: ## Build Docker image
	docker build -t webdev-portfolio:latest .

docker-run: ## Run Docker container
	docker-compose up -d

docker-stop: ## Stop Docker container
	docker-compose down

docker-logs: ## View Docker logs
	docker-compose logs -f

# Deployment
deploy: check build docker-build ## Build and deploy
	@echo "🚀 Deploying to production..."
	docker-compose up -d
	@echo "✅ Deployment complete! Check https://portfolio.davidfdzmorilla.dev"

# Utility
clean: ## Clean build artifacts
	rm -rf dist .astro node_modules/.astro

reset: clean ## Full reset (removes node_modules)
	rm -rf node_modules pnpm-lock.yaml

install: ## Install dependencies
	pnpm install

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
