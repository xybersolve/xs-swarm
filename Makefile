.PHONY: become ls \
				vis-up vis-down open-vis \
				portainer-up portainer-down portainer-open \
				zmq-up zmq-down zmq-ping zmq-inc zmq-open \
				gmp-up gmp-down gmp-open

ip := $(shell docker-machine ip mgr1)

become:
	@eval $(shell docker-machine env mgr1)

vis-up:
	@docker stack deploy --compose-file services/vis/deploy.yaml vis

vis-down:
	@docker stack rm vis

vis-open:
	open http://$(ip):9090

zmq-up:
	@docker stack deploy --compose-file services/zmq/deploy.yaml zmq

zmq-down: become
	@docker stack rm zmq

zmq-inc:
	@curl http://$(ip):8080/increment/24

zmq-ping:
	@curl http://$(ip):8080/ping

zmq-open:
	@open http://$(ip):8080/increment/24

portainer-up:
	@docker stack deploy --compose-file services/portainer/deploy.yaml portainer

portainer-down:
	@docker stack rm portainer

portainer-open:
	@open http://$(ip):9000

gmp-up:
	@docker stack deploy --compose-file services/gmp/deploy.yaml gmp

gmp-down: become
	@docker stack rm gmp

gmp-open:
	@open http://$(ip):8282/

ls:
	@docker stack ls
