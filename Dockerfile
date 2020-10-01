FROM alpine:edge

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && apk add --no-cache ca-certificates caddy  && \
    rm -rf /var/cache/apk/*
    
ADD mixcaddy.sh /mixcaddy.sh
RUN chmod +x /mixcaddy.sh

CMD /mixcaddy.sh
