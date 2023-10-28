package main

import (
	"fmt"
	pb "github.com/Valkinaz/kurultai_chat/proto"
	"github.com/Valkinaz/kurultai_chat/server"
	"google.golang.org/grpc"
	"log"
	"net"
)

var (
	network = "tcp"
	address = fmt.Sprintf(":%d", 50001)
)

func main() {
	listener, err := net.Listen(network, address)
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
