FROM alpine AS builder


# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
# ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gz
# RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

RUN apk add curl && curl -fsSL -O https://github.com/multiarch/qemu-user-static/releases/download/v5.2.0-2/qemu-i386-static
                            


FROM i386/golang:1.16.2-buster as build

# Add QEMU
COPY --from=builder qemu-i386-static /usr/bin



WORKDIR /src

# go.mod and go.sum if exists
COPY go.* ./
COPY *.go ./

RUN  GOOS=linux GOARCH=386 BIN_FILENAME="hello-${GOOS}-${GOARCH}${GOARM}"; GO111MODULE=off go build -ldflags="-s -w" -o ${BIN_FILENAME}


FROM i386/debian:buster

COPY --from=build  /src/hello-linux-386 /usr/bin/hello

ENV DEBIAN_FRONTEND noninteractive

RUN chmod +x /usr/bin/hello

CMD [ "/usr/bin/hello" ]
