.PHONY: help dev-up dev-down dev-logs server-run server-test server-fmt server-lint \
	web-install web-dev web-check web-lint mobile-get mobile-run mobile-test mobile-analyze \
	fmt lint test proto-lint proto-gen

.DEFAULT_GOAL := help

help: ## Show available targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

# --- Docker (PostgreSQL + API) ------------------------------------------------
dev-up: ## Build and start PostgreSQL + API
	docker compose up -d --build

dev-down: ## Stop the Docker stack
	docker compose down

dev-logs: ## Tail API logs
	docker compose logs -f api

# --- Server (Rust) ------------------------------------------------------------
server-run: ## Run the API locally (migrations on boot)
	cargo run --manifest-path server/Cargo.toml

server-test: ## Run server tests
	cargo test --manifest-path server/Cargo.toml

server-fmt: ## Format Rust code
	cargo fmt --manifest-path server/Cargo.toml

server-lint: ## Clippy (warnings are errors)
	cargo clippy --manifest-path server/Cargo.toml --all-targets -- -D warnings

# --- Web (SvelteKit) ----------------------------------------------------------
web-install: ## Install web dependencies
	cd web && npm install

web-dev: ## Start the web dev server (:5173)
	cd web && npm run dev

web-check: ## Type-check the web client
	cd web && npm run check

web-lint: ## Prettier + ESLint + svelte-check
	cd web && npm run lint && npm run check

# --- Mobile (Flutter) ---------------------------------------------------------
mobile-get: ## Resolve Flutter dependencies
	cd mobile && flutter pub get

mobile-run: ## Run the Flutter app
	cd mobile && flutter run

mobile-test: ## Run Flutter tests
	cd mobile && flutter test

mobile-analyze: ## Static analysis for Dart code
	cd mobile && flutter analyze

# --- Contracts (Protobuf) -----------------------------------------------------
proto-lint: ## Lint shared contracts with buf
	cd shared && npx --yes @bufbuild/buf lint

proto-gen: ## Generate TypeScript contracts
	cd shared && npx buf generate

# --- Aggregate ----------------------------------------------------------------
fmt: server-fmt ## Format everything (Rust; add `cd web && npm run format` / `dart format` for web/mobile)
	cd web && npm run format
	@if command -v dart >/dev/null 2>&1; then dart format mobile/lib mobile/test; fi

lint: server-lint web-lint proto-lint ## Lint everything
	@if command -v flutter >/dev/null 2>&1; then cd mobile && flutter analyze; fi

test: server-test ## Test everything
	@if command -v flutter >/dev/null 2>&1; then cd mobile && flutter test; fi
	cd web && npm run check
