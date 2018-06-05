# Load the environment variables
ifdef ENV
export ENV_FILE = .env.$(ENV)
else
export ENV_FILE = .env
endif

# Include the envionment variables in this Makefile
include $(ENV_FILE)

CONTAINER_NAME = serverless-prisma/devbox
NODE_CONTAINER = \
	--env-file $(ENV_FILE) \
	--interactive \
	--rm \
	--tty \
	--volume $(shell pwd):/var/task \
	--workdir /var/task \
	$(CONTAINER_NAME)

devbox:
	@docker build --no-cache --tag $(CONTAINER_NAME) .

install:
	@docker run $(NODE_CONTAINER) yarn install

dev:
	@docker run $(NODE_CONTAINER) /bin/bash

build:
	@docker run $(NODE_CONTAINER) yarn build

start:
	@docker run --publish 4000:4000 $(NODE_CONTAINER) yarn start

hard-start:
	rm -rf node_modules
	rm -f yarn.lock
	make devbox
	make install
	make start

deploy:
	@make deploy-prisma
	@make deploy-api

deploy-api:
	@docker run $(NODE_CONTAINER) yarn run deploy:api:$(ENV)

deploy-prisma:
	@docker run $(NODE_CONTAINER) yarn run deploy:prisma:$(ENV)

profile:
	@docker run $(NODE_CONTAINER) yarn run profile

tsc:
	@docker run $(NODE_CONTAINER) yarn run tsc

tslint:
	@docker run $(NODE_CONTAINER) yarn run tslint

tslint-fix:
	@docker run $(NODE_CONTAINER) yarn run tslint-fix
