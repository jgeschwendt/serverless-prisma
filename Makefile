ifdef ENV
export ENV_FILE = .env.$(ENV)
else
export ENV_FILE = .env
endif

include $(ENV_FILE)

docker:
	@docker build -t serverless/devbox .

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
