FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash wget curl

FROM caddy:2.1.1-alpine

RUN mkdir -p /usr/share/caddy
ADD entry.sh /entry.sh
ADD index.html /usr/share/caddy/index.html
RUN chmod +x /entry.sh

CMD /usr/share/caddy/entry.sh





