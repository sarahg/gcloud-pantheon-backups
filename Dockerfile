# syntax=docker/dockerfile:1

# Use Pantheon's PHP CI image.
FROM quay.io/pantheon-public/build-tools-ci:6.x

# Pull in Go for our webserver.
COPY --from=golang:1.14-buster /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"

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

# Copy local code to the container image.
COPY pan-sandbox-backups.sh ./

# Run the web service on container startup.
CMD ["/app/server"]