#!/bin/sh

# config caddy
mkdir -p /usr/share/caddy
wget -O /usr/share/caddy/index.html https://github.com/ringring1/mixcaddy/raw/master/index.html
cat << EOF > /etc/caddy/Caddyfile
:$PORT
root * /usr/share/caddy
file_server

EOF



# start
caddy run --config /etc/caddy/Caddyfile 
