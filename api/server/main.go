package main

import (
	"context"
	"log"
	"net"

	pb "github.com/parix/grpc-api/api/proto/echo"
	"google.golang.org/grpc"
)

const (
	port = ":9090"
)

// server is used to implement echo.APIServer.
type server struct {
	pb.UnimplementedAPIServer
}

// SayHello implements hello.APIServer
func (s *server) Get(ctx context.Context, req *pb.GetRequest) (*pb.GetResponse, error) {
	log.Printf("Received: %v", req.GetMessage())
	return &pb.GetResponse{Echo: req.GetMessage()}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterAPIServer(s, &server{})
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
