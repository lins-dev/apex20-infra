export UID := $(shell id -u)
export GID := $(shell id -g)

.PHONY: up down restart build logs ps

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose restart

build:
	docker compose build --no-cache tooling

logs:
	docker compose logs -f

ps:
	docker compose ps
