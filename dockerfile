FROM golang:1.23.9 AS build
MAINTAINER GitHub, Inc.

WORKDIR /go/src/github.com/git-lfs/lfs-test-server

COPY . .

RUN go build

FROM debian:bookworm-slim
COPY --from=build /go/src/github.com/git-lfs/lfs-test-server/lfs-test-server /usr/bin/lfs-test-server
WORKDIR /data/lfs-server

EXPOSE 8080

CMD /usr/bin/lfs-test-server

