FROM golang:1.24.1-alpine AS builder

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o /main ./cmd/app

FROM alpine:3.20

COPY --from=builder /main /main

EXPOSE 8080

ENTRYPOINT ["./main"]
