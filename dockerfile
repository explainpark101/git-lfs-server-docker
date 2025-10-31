FROM golang:1.23.9 AS build

MAINTAINER GitHub, Inc.

RUN apt-get update && apt-get install -y git

WORKDIR /go/src/github.com/git-lfs/lfs-test-server

RUN git clone https://github.com/git-lfs/lfs-test-server.git .

RUN go mod tidy
RUN go build

FROM debian:bookworm-slim
COPY --from=build /go/src/github.com/git-lfs/lfs-test-server/lfs-test-server /usr/bin/lfs-test-server
WORKDIR /data/lfs-server

EXPOSE 8080

CMD /usr/bin/lfs-test-server