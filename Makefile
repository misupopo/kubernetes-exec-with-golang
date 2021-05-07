GO_SRCS := $(shell find . -type f -name '*.go')

docker-build:
	bash ./scripts/build.sh
