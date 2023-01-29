// Code generated by github.com/douyu/proto/cmd/protoc-gen-go-echo. DO NOT EDIT.

package helloworldv1

import (
	context "context"
	v4 "github.com/labstack/echo/v4"
	metadata "google.golang.org/grpc/metadata"
	http "net/http"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the github.com/douyu/proto/cmd/protoc-gen-go-echo package it is being compiled against.
// http.
// context.
// metadata.
// v4.echo

type GreeterServiceEchoServer interface {
	SayHello(context.Context, *SayHelloRequest) (*SayHelloResponse, error)

	SayHi(context.Context, *SayHiRequest) (*SayHiResponse, error)
}

func RegisterGreeterServiceEchoServer(r *v4.Echo, srv GreeterServiceEchoServer) {
	s := _GreeterService{
		server: srv,
		router: r,
	}
	s.registerService()
}

type _GreeterService struct {
	server GreeterServiceEchoServer
	router *v4.Echo
}

func (s *_GreeterService) _handler_SayHello_0(ctx v4.Context) error {
	var in SayHelloRequest
	if err := ctx.Bind(&in); err != nil {
		ctx.Error(v4.NewHTTPError(200, err))
		return nil
	}
	md := metadata.New(nil)
	for k, v := range ctx.Request().Header {
		md.Set(k, v...)
	}
	newCtx := metadata.NewIncomingContext(ctx.Request().Context(), md)
	out, err := s.server.(GreeterServiceEchoServer).SayHello(newCtx, &in)
	if err != nil {
		ctx.Error(v4.NewHTTPError(200, err))
		return nil
	}

	return ctx.JSON(http.StatusOK, out)
}

func (s *_GreeterService) _handler_SayHi_0(ctx v4.Context) error {
	var in SayHiRequest
	if err := ctx.Bind(&in); err != nil {
		ctx.Error(v4.NewHTTPError(200, err))
		return nil
	}
	md := metadata.New(nil)
	for k, v := range ctx.Request().Header {
		md.Set(k, v...)
	}
	newCtx := metadata.NewIncomingContext(ctx.Request().Context(), md)
	out, err := s.server.(GreeterServiceEchoServer).SayHi(newCtx, &in)
	if err != nil {
		ctx.Error(v4.NewHTTPError(200, err))
		return nil
	}

	return ctx.JSON(http.StatusOK, out)
}

func (s *_GreeterService) registerService() {

	s.router.Add("POST", "/v1/helloworld.Greeter/SayHello", s._handler_SayHello_0)

	s.router.Add("POST", "hi", s._handler_SayHi_0)

}
