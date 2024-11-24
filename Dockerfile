# Use the official Golang image as a base
FROM golang:1.19-alpine as builder

# Set the working directory
WORKDIR /app

# Copy the Go modules and code
COPY go.mod ./
RUN go mod download
COPY . .

# Build the Go app
RUN go build -o hello-service .

# Start a new stage from scratch
FROM alpine:latest

# Copy the binary from the builder stage
COPY --from=builder /app/hello-service .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./hello-service"]