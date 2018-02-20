help:
	@echo "make help\tShows this help information"
	@echo "make compile-deps\tCompiles requirements into locked file"
.PHONY: help

compile-deps:
	docker-compose run --rm build pip-compile requirements.in
.PHONY: compile-deps
