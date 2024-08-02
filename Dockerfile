FROM golang:1.20-alpine AS builder

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY src ./src

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /app/main ./src/main.go

FROM scratch

COPY --from=builder /app/main /main

ENTRYPOINT ["/main"]
