ifdef ENV
export ENV_FILE = .env.$(ENV)
else
export ENV_FILE = .env
endif

include $(ENV_FILE)

devbox:
	@docker build --no-cache --tag serverless/devbox .
	@make install

install:
	@docker run --interactive --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox /root/.yarn/bin/yarn install

dev:
	@docker run \
	  --env-file $(ENV_FILE) \
		--interactive \
		--rm \
		--tty \
		--volume $(shell pwd):/code \
		--workdir /code \
	serverless/devbox /bin/bash

build:
	@docker run --env-file $(ENV_FILE) --interactive --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox /root/.yarn/bin/yarn build

start:
	@docker run --env-file $(ENV_FILE) --interactive --publish 4000:4000 --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox /root/.yarn/bin/yarn start

hard-start:
	rm -rf node_modules
	rm yarn.lock
	make install
	make start

deploy:
	@make deploy-prisma
	@make deploy-api

deploy-api:
	@docker run --env-file $(ENV_FILE) --interactive --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox /root/.yarn/bin/yarn run deploy:api:$(ENV)

deploy-prisma:
	@docker run --env-file $(ENV_FILE) --interactive --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox /root/.yarn/bin/yarn run deploy:prisma:$(ENV)

tsc:
	@docker run --env-file $(ENV_FILE) --interactive --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox /root/.yarn/bin/yarn run tsc
