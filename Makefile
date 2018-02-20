help:
	@echo "make help            Shows this help information"
	@echo "make compile-deps    Compiles requirements into locked file"
	@echo "make init            Initializes the devpi data"
	@echo "make deinit          Destroys the devpi data"
	@echo "make up              Starts the devpi server"
	@echo "make down            Stops the devpi server"
	@echo "make puma-dev        Setups the puma-dev"
.PHONY: help

compile-deps:
	docker-compose run --rm build pip-compile requirements.in
.PHONY: compile-deps

init:
	docker-compose build
	docker-compose run --rm devpi --init
.PHONY: init

deinit:
	rm -rf lib
.PHONY: deinit

up:
	docker-compose up --build --abort-on-container-exit devpi ldap ldap-admin
.PHONY: up

down:
	docker-compose down
.PHONY: down

puma-dev:
	echo "http://$$(docker-compose port devpi 80)" > ~/.puma-dev/devpi.example
	echo "tcp://$$(docker-compose port ldap 389)" > ~/.puma-dev/ldap.example
	echo "http://$$(docker-compose port ldap-admin 80)" > ~/.puma-dev/ldap-admin.example
.PHONY: puma-dev
