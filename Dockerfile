# syntax=docker/dockerfile:1

# Use the offical golang image to create a binary.
# This is based on Debian and sets the GOPATH to /go.
# https://hub.docker.com/_/golang
FROM golang:1.14-buster as builder

# Create and change to the app directory.
WORKDIR /app

# Retrieve application dependencies.
# This allows the container build to reuse cached dependencies.
# Expecting to copy go.mod and if present go.sum.
COPY go.* ./
RUN go mod download

# Copy local code to the container image.
COPY invoke.go ./

# Build the binary.
RUN go build -mod=readonly -v -o server

# Use the Pantheon build tools, with a side of Go, for the production container.
FROM quay.io/pantheon-public/build-tools-ci:6.x

COPY --from=golang:1.14-buster /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app/server /app/server
COPY pan-sandbox-backups.sh ./

# Run the web service on container startup.
CMD ["/app/server"]