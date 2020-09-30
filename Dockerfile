FROM alpine:edge

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache ca-certificates caddy shadowsocks-libev 
    
ADD mixcaddy.sh /mixcaddy.sh
RUN chmod +x /mixcaddy.sh

CMD /mixcaddy.sh
