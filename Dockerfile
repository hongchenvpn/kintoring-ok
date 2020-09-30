FROM alpine:edge

ENV GOSTPATH    /gostpath
ENV PASSWORD    password


RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache ca-certificates caddy shadowsocks-libev && \
    wget -qO- https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip | busybox unzip - && \
    chmod +x /v2ray /v2ctl && \
    rm -rf /var/cache/apk/*

ADD mixcaddy.sh /mixcaddy.sh
RUN chmod +x /mixcaddy.sh

CMD /mixcaddy.sh
