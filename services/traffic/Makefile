.PHONY: up down test1 test2 scale-up scale-down

network:
	@docker network create --driver overlay --attachable traffic-net

up:
	@docker-compose up -d

down:
	@docker-compose down

scale-up:
	@docker-compose up -d --scale machine=2
	@docker-compose up -d --scale echo=2

scale-up:
	@docker-compose up -d --scale machine=1
	@docker-compose up -d --scale echo=1

test1:
	@curl -H Host:machine-echo.dev.com http://dev.com

test2:
	@curl -H Host:echo-echo.dev.com http://dev.com
