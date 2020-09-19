# 							  Makefile help							 *
define USAGE
Discord bot docker ⚙️

Commands:
	BASE:
	build           : Build Docker image
	run             : Run Docker image
endef

export USAGE

# 							Docker Variables						 *

PREFIX=remcoha
APP_NAME=testing_bot
IMG_REGISTRY=docker.io/$(PREFIX)
VERSION=0.0.1
LOCAL_PORT=8080
EXPOSE_PORT=3150
IMG_NAME=$(IMG_REGISTRY)/$(APP_NAME):$(VERSION)

help:
	@echo "$$USAGE"

build:
	docker build -t $(IMG_NAME) .

run:
	docker run -d -p $(EXPOSE_PORT):$(LOCAL_PORT) $(IMG_NAME)

buildrun: build run