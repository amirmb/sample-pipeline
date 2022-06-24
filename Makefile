# Compose Commands
# COMPOSE_RUN_CFN = docker-compose run --rm awscli
COMPOSE_RUN_APP = docker-compose run --rm app
COMPOSE_RUN_DB  = docker-compose up -d db

# Create .env from template
.env:
	cp -f .env.template .env

database:
	$(COMPOSE_RUN_DB)

prepare: .env
	docker-compose build
.PHONY: prepare

lint: .env
	$(COMPOSE_RUN_APP) make _lint
.PHONY: lint

cfn_validation: .env
	$(COMPOSE_RUN_CFN) make _cfn_validation
.PHONY: cfn_validation

security: .env
	$(COMPOSE_RUN_APP) make _security
.PHONY: security

test: .env
	$(COMPOSE_RUN_APP) make _test
.PHONY: test

build: .env
	$(COMPOSE_RUN_APP) make _build
.PHONY: build

cleanDocker: .env
	docker-compose down --remove-orphans --volumes

_build:
	bash cicd/scripts/build.sh

_test:
	bash cicd/scripts/test.sh

_security:
	bash cicd/scripts/security.sh

_cfn_validation:
	bash cicd/scripts/cfn_validation

_lint:
	bash cicd/scripts/lint.sh
