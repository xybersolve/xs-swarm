.PHONY: up down ssh-db logs-db help \
	pwd-root pwd-dba login-db

up:
	#@docker-compose -f docker-stack.yaml up
	@docker stack deploy -c stack.yaml wp

down:
	@docker stack rm mysql

ssh-db:
	@docker exec -it $$(docker service ps wp_db -q) bash

logs-db:
	@docker logs $$(docker service ps wp_db -q)

login-db:
	docker exec -it $$(docker service ps wp_db -q) mysql -u root -p

pwd-root:
	docker exec -it $$(docker service ps wp_db -q) cat /run/secrets/db_root_pwd

pwd-dba:
	docker exec -it $$(docker service ps wp_db -q) cat /run/secrets/db_dba_pwd

help:
	@echo Review secrets:
	@echo docker exec -it $$(docker service ps wp_db -q) ls /run/secrets/
	@echo Read db password
	@echo docker exec -it $$(docker service ps wp_db -q) cat /run/secrets/db_root_pwd
