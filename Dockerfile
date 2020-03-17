# See https://codefresh.io/docs/docs/learn-by-example/golang/golang-hello-world/

FROM golang:1.13.8-alpine3.11 AS build_base

RUN apk add --no-cache git

# Set the Current Working Directory inside the container
WORKDIR /tmp/echo-k8s-sample-app

# We want to populate the module cache based on the go.{mod,sum} files.
COPY go.mod .
COPY go.sum .

RUN go mod download

COPY server.go .

# Unit tests
RUN CGO_ENABLED=0 go test -v

# Build the Go app
RUN go build -o ./out/echo-k8s-sample-app .

# Start fresh from a smaller image
FROM alpine:3.11
RUN apk add ca-certificates

COPY --from=build_base /tmp/echo-k8s-sample-app/out/echo-k8s-sample-app /app/echo-k8s-sample-app

# This container exposes port 8080 to the outside world
EXPOSE 80

# Run the binary program produced by `go install`
CMD ["/app/echo-k8s-sample-app"]