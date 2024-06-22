WEB_DB_NAME = odoo_development # <- put your Odoo database name here
DOCKER = docker
DOCKER_COMPOSE = $(DOCKER) compose
CONTAINER_ODOO = odoo
CONTAINER_DB = odoo-postgres

help:
	@echo "Available targets:"
	@echo "  start                  Start the compose with daemon"
	@echo "  stop                   Stop the compose"
	@echo "  restart                Restart the compose"
	@echo "  psql                   PostgreSQL interactive shell"
	@echo "  logs odoo              Logs the odoo container"
	@echo "  logs db                Logs the odoo-postgres container"

start:
	$(DOCKER_COMPOSE) up -d

stop:
	$(DOCKER_COMPOSE) down

restart:
	$(DOCKER_COMPOSE) restart

psql:
	$(DOCKER) exec -it $(CONTAINER_DB) psql -U $(CONTAINER_ODOO) -d $(WEB_DB_NAME)

define log_target
	@if [ "$(1)" = "odoo" ]; then \
		$(DOCKER_COMPOSE) logs -f $(CONTAINER_ODOO); \
	elif [ "$(1)" = "db" ]; then \
		$(DOCKER_COMPOSE) logs -f $(CONTAINER_DB); \
	else \
		echo "Invalid logs target. Use 'make logs odoo' or 'make logs db'."; \
	fi
endef

logs:
	$(call log_target,$(word 2,$(MAKECMDGOALS)))

.PHONY: start stop restart psql logs odoo db
