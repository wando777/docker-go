FROM golang AS builder

WORKDIR /go/src/app

RUN go mod init app

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /go/src/app/app .

FROM scratch

COPY --from=builder /go/src/app/app /app/app

EXPOSE 3000

ENTRYPOINT ["/app/app"]