FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN rm go.mod go.sum

RUN go mod init github.com/yoursunny/ndpresponder && go mod tidy

RUN CGO_ENABLED=0 go build -ldflags "-w -s" -o ndpresponder

FROM scratch

COPY --chown=65532 --from=builder /app/ndpresponder /app/ndpresponder

ENTRYPOINT [ "/app/ndpresponder" ]
