#!/bin/bash
docker run -i --rm golang:1.5.1 > forego <<END
apt-get update 1> /dev/null && apt-get install -yy musl-dev musl-tools 1> /dev/null
go get github.com/ddollar/forego 1> /dev/null
cd /go/src/github.com/ddollar/forego 1> /dev/null
CC=musl-gcc go build  --ldflags '-linkmode external -extldflags "-static -s"' 1> /dev/null
cat forego
END
