package main

import (
	"fmt"
	"github.com/Valkinaz/kurultai_chat/config"
	pb "github.com/Valkinaz/kurultai_chat/proto"
	"github.com/Valkinaz/kurultai_chat/server"
	"github.com/joho/godotenv"
	"google.golang.org/grpc"
	"log"
	"net"
)

func init() {
	_ = godotenv.Load(".env.local")
}

func main() {
	appConfig, err := config.New()
	if err != nil {
		log.Fatalf("Не удалось загрузить конфигурацию: %v", err)
	}

	address := fmt.Sprintf(":%s", appConfig.Port)
	listener, err := net.Listen("tcp", address)
	if err != nil {
		log.Fatalf("Не удалось начать слушать порт: %v", err)
	}

	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	pb.RegisterKurultaiChatServer(grpcServer, server.NewKurultaiChatServer())

	err = grpcServer.Serve(listener)
	if err != nil {
		log.Fatalf("Не удалось запустить gRPC сервер: %v", err)
	}
}
