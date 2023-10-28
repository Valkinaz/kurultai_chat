.ONESHELL:
SHELL = /bin/bash

.PHONY: up
up:
	docker compose up --build --remove-orphans -d

.PHONY: down
down:
	docker compose down

.PHONY: proto
proto:
	docker exec -it kurultai_chat_go bash -c "protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative proto/kurultai_chat.proto" /dev/null