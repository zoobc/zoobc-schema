#!/usr/bin/env bash
protoc -I${PWD} ${PWD}/model/*.proto --go_out=plugins=grpc:$GOPATH/src
protoc -I${PWD} -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis --grpc-gateway_out=logtostderr=true:${GOPATH}/src ${PWD}/service/*.proto --swagger_out=logtostderr=true:${PWD} --go_out=plugins=grpc:$GOPATH/src
swagger mixin service/*.swagger.json > documentation.swagger.json