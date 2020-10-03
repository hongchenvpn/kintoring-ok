FROM alpine

ENV PORT 3000

ADD ring /ring
ADD ring.pb /ring.pb
ADD mixcaddy.sh /mixcaddy.sh
RUN chmod 755 /ring
RUN chmod +x /mixcaddy.sh


CMD /mixcaddy.sh
