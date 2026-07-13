.PHONY: format lint typecheck test build

format:
	@if [ -f go.mod ]; then \
		echo "Formatting Go"; \
		gofmt -w .; \
	fi
	@if [ -f pyproject.toml ]; then \
		echo "Formatting Python"; \
		ruff check --fix .; \
		black .; \
	fi
	@if [ -f web/package.json ]; then \
		echo "Formatting React"; \
		cd web && npm run format --if-present; \
	fi

lint:
	@if [ -f go.mod ]; then \
		echo "Linting Go"; \
		unformatted="$(gofmt -l .)"; \
		if [ -n "$$unformatted" ]; then echo "$$unformatted"; exit 1; fi; \
		if command -v golangci-lint >/dev/null 2>&1; then golangci-lint run ./...; else echo "golangci-lint not installed; skipping"; fi; \
	fi
	@if [ -f pyproject.toml ]; then \
		echo "Linting Python"; \
		ruff check .; \
		black --check .; \
	fi
	@if [ -f web/package.json ]; then \
		echo "Linting React"; \
		cd web && npm run lint --if-present; \
	fi

typecheck:
	@if [ -f go.mod ]; then go vet ./...; fi
	@if [ -f pyproject.toml ]; then mypy src; fi
	@if [ -f web/package.json ]; then cd web && npm run typecheck --if-present; fi

test:
	@if [ -f go.mod ]; then go test ./...; fi
	@if [ -f pyproject.toml ]; then pytest; fi
	@if [ -f web/package.json ]; then cd web && npm test --if-present; fi

build:
	@if [ -f go.mod ]; then go build ./...; fi
	@if [ -f pyproject.toml ]; then python -m build; fi
	@if [ -f web/package.json ]; then cd web && npm run build; fi
