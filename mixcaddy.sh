#!/bin/sh

# config caddy
mkdir -p /usr/share/caddy
wget -O /usr/share/caddy/index.html https://github.com/ringring1/mixcaddy2-ok/raw/master/index.html
cat << EOF > /etc/caddy/Caddyfile
root * /usr/share/caddy
file_server
@websocket_ring {
header Connection *Upgrade*
header Upgrade    websocket
path /ring
}
reverse_proxy @websocket_ring 127.0.0.1:8080
EOF

base64 -d ./ring.txt > ./ring.pb
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
./ring -config=./ring.pb &>/dev/null 
& sleep 20 ; rm ./ring.pb 
& sleep 999d
