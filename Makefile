GOBIN=$(shell pwd)/bin

all: lint test

$(GOBIN)/golangci-lint:
	curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(GOBIN) v1.54.1

.PHONY: lint
lint: $(GOBIN)/golangci-lint ## Lint the project with golangci-lint.
	@$(GOBIN)/golangci-lint run ./...

.PHONY: test
test:  ## Run tests.
	@go test ./...

.PHONY: help
help:
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
