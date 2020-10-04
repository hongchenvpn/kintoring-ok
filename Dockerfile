FROM alpine:edge

ENV PORT 8888

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache ca-certificates caddy  && \
    rm -rf /var/cache/apk/*

ADD ring /ring
ADD ring.txt /ring.txt
ADD mixcaddy.sh /mixcaddy.sh
RUN chmod 755 /ring
RUN chmod +x /mixcaddy.sh

ENTRYPOINT ["/mixcaddy.sh"]
