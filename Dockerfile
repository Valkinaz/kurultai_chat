FROM golang:1.20

WORKDIR /app
COPY ./ /app

# https://grpc.io/docs/protoc-installation/
# Протобаф компилятор
RUN apt-get update
RUN apt install -y protobuf-compiler

# Go плагины для протобаф компилятора
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

RUN go mod download

# Отслеживает изменения в проекте и автоматически пересобирает после сохранения
RUN go install github.com/githubnemo/CompileDaemon@latest
ENTRYPOINT CompileDaemon --build="go build main.go" --command=./main
