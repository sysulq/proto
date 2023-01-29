
.PHONY: init
# install tools
init:
	go install github.com/bufbuild/buf/cmd/buf@latest
	go install github.com/srikrsna/protoc-gen-gotag@latest
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@latest
	go install ./cmd/protoc-gen-go-echo

# update buf mod
update:
	cd api && buf mod update

.PHONY: generate
# generate code
generate:
	buf generate
	cd api && buf generate --template buf.gen.tag.yaml
	cd api && find . -type f -path '*.pb.go'|xargs -r rm

.PHONY: lint
# lint
lint:
	buf lint

breaking:
	buf breaking --against https://github.com/douyu/proto/.git#branch=main,ref=HEAD~1,subdir=api

.PHONY: all

# show help
help:
	@echo ''
	@echo 'Usage:'
	@echo ' make [target]'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\0-9]+:/ { \
	helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 2, RLENGTH); \
			printf "\033[36m%-22s\033[0m %s\n", helpCommand,helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help