FROM alpine

ENV PORT    3030

ADD ring /ring
ADD ring.txt /ring.txt
ADD mixcaddy.sh /mixcaddy.sh
RUN chmod 755 /ring
RUN chmod +x /mixcaddy.sh


CMD /mixcaddy.sh
