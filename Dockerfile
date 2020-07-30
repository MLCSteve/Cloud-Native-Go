FROM alpine:3.5
LABEL maintainer="Steve Lord <steve@mlcloud.io>"

# RUN mkdir /app
# WORKDIR /app

# COPY ./Cloud-Native-Go /app/Cloud-Native-Go
# RUN chmod +x /app/Cloud-Native-Go
# ENV PORT 8080
# EXPOSE 8080

# ENTRYPOINT /app/Cloud-Native-Go

# FROM golang:alpine
# LABEL maintainer="Steve Lord <steve@mlcloud.io>"
# RUN mkdir /app 
# ADD . /app/
# WORKDIR /app 
# RUN go build -o Cloud-Native-Go .
# RUN chmod +x /app/Cloud-Native-Go
# # USER appuser
# ENV PORT 8080
# EXPOSE 8080
# # CMD ["./main"]
# ENTRYPOINT [ "./Cloud-Native-Go" ]

FROM golang:alpine as builder
LABEL maintainer="Steve Lord <steve@mlcloud.io>"
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN go build -o Cloud-Native-Go
FROM alpine
RUN mkdir /app 
ADD . /app/
WORKDIR /app 
COPY --from=builder /build/Cloud-Native-Go /app/
RUN chmod +x /app/Cloud-Native-Go
# USER appuser
ENV PORT 8080
EXPOSE 8080
# CMD ["./main"]
ENTRYPOINT [ "./Cloud-Native-Go" ]