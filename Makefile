# ================================================================== *
# 							  Makefile help							 *
# ================================================================== *

define USAGE
Holiday Countdown ⚙️

Commands:
	BASE:
	build           : Build Docker image
	run             : Run Docker image
	destroy_empty   : Destroy empty docker images
	_____________________________________________
	VUE:
	serve			: Run local Vue instance
	build_vue		: Builds vue app
	fix_vue			: Vue linting
	_____________________________________________
endef

export USAGE

# ================================================================== *
# 							Docker Variables						 *
# ================================================================== *

PREFIX=remcoha
APP_NAME=testing_bot
IMG_REGISTRY=docker.io/$(PREFIX)
VERSION=0.0.1
LOCAL_PORT=8080
EXPOSE_PORT=3150
IMG_NAME=$(IMG_REGISTRY)/$(APP_NAME):$(VERSION)

# ================================================================== *
# 						    Docker Utils							 *
# ================================================================== *

help:
	@echo "$$USAGE"

destroy_empty:
	docker rmi $$(docker images --filter "dangling=true" -q --no-trunc)

# ================================================================== *
# 						Docker specific tasks						 *
# ================================================================== *

build:
	docker build -t $(IMG_NAME) .

run:
	docker run -d -p $(EXPOSE_PORT):$(LOCAL_PORT) $(IMG_NAME)

buildrun: build run

stats:
	@docker ps --format 'CONTAINER ID : {{.ID}} | Name: {{.Names}} | Image:  {{.Image}} |  Ports: {{.Ports}}'

stop: ## Stop and remove a running container
	docker stop $$(docker ps -q --filter ancestor=$(PREFIX)/$(APP_NAME):$(VERSION) --format="{{.ID}}" )

