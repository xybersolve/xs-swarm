.PHONY: up down clean

include env.mk

up:
	@docker stack deploy -c deploy.yaml $(PROJECT)

down:
	@docker stack rm $(PROJECT) || true

clean: down
	@docker image rm traefik
