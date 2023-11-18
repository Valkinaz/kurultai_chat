.ONESHELL:
SHELL = /bin/bash

.PHONY: build
build:
	docker build .

.PHONY: up
up:
	docker compose up -d

.PHONY: down
down:
	docker compose down

.PHONY: cli
cli:
	docker exec -it kurultai_chat_go bash

.PHONY: proto
proto:
	docker exec -it kurultai_chat_go bash -c "protoc --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative proto/kurultai_chat.proto" /dev/null