FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash wget curl

FROM caddy:2.1.1-alpine

RUN mkdir -p /usr/share/caddy
ADD entry.sh /usr/share/caddy/entry.sh
ADD index.html /usr/share/caddy/index.html
RUN chmod +x /usr/share/caddy/entry.sh

EXPOSE 8080 
CMD /usr/share/caddy/entry.sh





