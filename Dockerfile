FROM golang:1.21-alpine3.18 as build
ARG SERVICE
WORKDIR /app/
COPY . .
RUN go env -w GOPROXY=direct
RUN CGO_ENABLED=0 go build -o main cmd/$SERVICE/main.go

FROM alpine:3.18
COPY --from=build /app/main /app/main
CMD ["/app/main"]