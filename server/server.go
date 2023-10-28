package server

import (
	"context"
	kurultai_chat "github.com/Valkinaz/kurultai_chat/proto"
)

type KurultaiChatServer struct {
	kurultai_chat.UnimplementedKurultaiChatServer
}

func NewKurultaiChatServer() *KurultaiChatServer {
	s := &KurultaiChatServer{}
	return s
}

func (s *KurultaiChatServer) SendMessage(ctx context.Context, message *kurultai_chat.Message) (*kurultai_chat.Message, error) {
	return &kurultai_chat.Message{Content: "Content response message"}, nil
}
