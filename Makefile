REGISTRY         ?= docker.io
ORG              ?= ansibleplaybookbundle
TAG              ?= latest
BROKER_IMAGE     ?= $(REGISTRY)/$(ORG)/origin-ansible-service-broker
VARS             ?= ""
BUILD_DIR        = "${GOPATH}/src/github.com/openshift/ansible-service-broker/build"
PREFIX           ?= /usr/local
BROKER_CONFIG    ?= $(PWD)/etc/generated_local_development.yaml
SOURCE_DIRS      = cmd pkg
SOURCES          := $(shell find . -name '*.go')
.DEFAULT_GOAL    := build

vendor: ## Install or update project dependencies
	@glide install -v

main: $(SOURCES) ## Build the broker
	go build -i -ldflags="-s -w" ./cmd/main

build: main ## Build binary from source
	@echo > /dev/null

lint: ## Run golint
	@golint -set_exit_status $(addsuffix /... , $(SOURCE_DIRS))

fmt: ## Run go fmt
	@gofmt -d $(SOURCES)

fmtcheck: ## Check go formatting
	@gofmt -l $(SOURCES) | grep ".*\.go"; if [ "$$?" = "0" ]; then exit 1; fi

test: ## Run unit tests
	@go test -cover ./pkg/...

test-coverage-html: coverage-all.out ## checkout the coverage locally of your tests
	@go tool cover -html=coverage-all.out

ci-test-coverage: coverage-all.out ## CI test coverage, upload to coveralls
	@goveralls -coverprofile=coverage-all.out -service $(COVERAGE_SVC)

vet: ## Run go vet
	@go tool vet ./cmd ./pkg

check: fmtcheck vet lint build test ## Pre-flight checks before creating PR

run: build
	@./main

clean: ## Clean up your working environment
	@rm -f main
