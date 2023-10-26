package server

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

// Server is used to implement echo.APIServer.
type Server struct {
	pb.UnimplementedAPIServer
}

func NewServer() *Server {
  return &Server{}
}

// SayHello implements hello.APIServer
func (s *Server) Get(ctx context.Context, req *pb.GetRequest) (*pb.GetResponse, error) {
	log.Printf("Received: %v", req.GetMessage())
  return &pb.GetResponse{Echo: req.GetMessage()}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterAPIServer(s, NewServer())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
