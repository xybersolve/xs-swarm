.PHONY: up down clean log-req log-res

include env.mk

network-up:
	docker network create -d overlay $(NETWORK) || true

up: network-up
	@docker stack deploy -c deploy.yaml zmq

down:
	@docker stack rm zmq || true

clean: down
	@docker image rm xybersolve/zmq-http-req
	@docker image rm xybersolve/zmq-http-res

logs-req:
	docker service logs $$(docker service ps zmq_requestor -q)

logs-res:
	docker service logs $$(docker service ps zmq_responder -q)
