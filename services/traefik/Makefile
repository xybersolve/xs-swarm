.PHONY: up down clean run cur-dir

include env.mk

NETWORK := traefik-net
CURDIR := $(PWD)

network-up:
	#@docker network create -d overlay $(NETWORK) || true
	@docker network create --driver overlay --attachable $(NETWORK) || true

up: network-up
	@docker stack deploy -c deploy.yaml $(PROJECT)

cur-dir:
	@echo $(CURDIR)

run:
	@docker run -d \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(PWD)/traefik.toml:/traefik.toml \
		-v $(PWD)/acme.json:/acme.json \
		-p 80:80 \
		-p 443:443 \
		-l traefik.frontend.rule=Host:monitor.example.com \
		-l traefik.port=8080 \
		--network $(NETWORK) \
		--name traefik \
		traefik:1.3.6-alpine --docker


down:
	@docker stack rm $(PROJECT) || true

clean: down
	@docker image rm traefik
