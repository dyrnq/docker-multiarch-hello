FROM golang:1.16.2 as build


WORKDIR /src

# go.mod and go.sum if exists
#COPY go.* ./
COPY *.go ./

RUN  GOOS=linux GOARCH=amd64 BIN_FILENAME="hello-${GOOS}-${GOARCH}"; GO111MODULE=off go build -ldflags="-s -w" -o ${BIN_FILENAME}


FROM debian:buster

COPY --from=build  /src/hello-linux-amd64 /usr/bin/hello

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /usr/bin/hello

CMD [ "/usr/bin/hello" ]
