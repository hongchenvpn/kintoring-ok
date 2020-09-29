FROM alpine:edge

ENV V2RAYPATH   /v2raypath

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache ca-certificates caddy && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /wwwroot
ADD entry.sh /entry.sh
ADD index.html /wwwroot/index.html
RUN chmod +x /entry.sh

CMD /entry.sh





