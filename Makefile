ifdef ENV
export ENV_FILE = .env.$(ENV)
else
export ENV_FILE = .env
endif

include $(ENV_FILE)

docker:
	@docker build --no-cache --tag serverless/devbox .

install:
	@docker run --interactive --rm --tty --volume $(shell pwd):/code --workdir /code serverless/devbox yarn install

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
	@docker run --env-file $(ENV_FILE) --interactive --publish 4000:4000 --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox yarn build

start:
	@docker run --env-file $(ENV_FILE) --interactive --publish 4000:4000 --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox yarn start

deploy-api:
	@docker run --env-file $(ENV_FILE) --interactive --publish 4000:4000 --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox yarn run deploy:api:$(ENV)

deploy-prisma:
	@docker run --env-file $(ENV_FILE) --interactive --publish 4000:4000 --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox yarn run deploy:prisma:$(ENV)

tsc:
	@docker run --env-file $(ENV_FILE) --interactive --publish 4000:4000 --rm --tty --volume $(shell pwd):/code --workdir /code \
	serverless/devbox yarn run tsc
