package server_test

import (
  "testing"
  "github.com/stretchr/testify/assert"

  "context"
  "github.com/parix/grpc-api/api/server"
	pb "github.com/parix/grpc-api/api/proto/echo"
)

// TestHelloName calls greetings.Hello with a name, checking
// for a valid return value.
func TestHelloName(t *testing.T) {
  s := server.NewServer()

  ctx := context.Background()
  req := &pb.GetRequest{
    Message: "Hello World!",
  }

  res, err := s.Get(ctx, req) 
  assert.Nil(t, err)
  assert.NotNil(t, res)
  assert.Equal(t, "Hello World!", res.GetEcho())
}
