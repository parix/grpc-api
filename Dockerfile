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
RUN go install github.com/golang/protobuf/protoc-gen-go@latest
WORKDIR /go/src/github.com/parix/grpc-api

FROM base as server
RUN go install github.com/parix/grpc-api/api/server@latest
ENTRYPOINT ["/go/bin/server"]

FROM envoyproxy/envoy-dev:latest as envoy
RUN apt-get update && apt-get -q install -y curl
CMD /usr/local/bin/envoy -c /etc/front-envoy.yaml --service-cluster front-proxy
