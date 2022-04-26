.PHONY: up down

include env.mk

network:
	@docker network create --driver overlay --attachable $(TRAEFIK_NETWORK)

up:
	@docker stack

down:
