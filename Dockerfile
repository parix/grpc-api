FROM golang as base
RUN apt-get update
ADD . /go/src/github.com/parix/grpc-api

FROM base as dev
RUN apt-get install -y unzip
RUN PROTOC_ZIP=protoc-3.7.1-linux-x86_64.zip \
    && curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.7.1/$PROTOC_ZIP \
    && unzip -o $PROTOC_ZIP -d /usr/local bin/protoc \
    && unzip -o $PROTOC_ZIP -d /usr/local 'include/*' \
    && rm -f $PROTOC_ZIP
RUN go get -u github.com/golang/protobuf/protoc-gen-go \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway \
    && go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
WORKDIR /go/src/github.com/parix/grpc-api

FROM base as server
RUN go install github.com/parix/grpc-api/api/server
ENTRYPOINT ["/go/bin/server"]
EXPOSE 9090

FROM base as gateway
RUN go install github.com/parix/grpc-api/api/gateway
ENTRYPOINT ["/go/bin/gateway"]
EXPOSE 8081
