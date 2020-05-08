go:
	protoc -I /usr/local/include -I. \
		-I ${GOPATH}/src \
		-I third_party/googleapis \
		--go_out=plugins=grpc:. \
		api/proto/echo/echo.proto

descriptor:
	protoc -I /usr/local/include -I. \
		-I ${GOPATH}/src \
		-I third_party/googleapis \
		--include_imports \
		--descriptor_set_out=api/proto/echo/echo.pb \
		api/proto/echo/echo.proto
