#!/bin/sh

# config caddy
mkdir -p /etc/caddy/
cat << EOF > /etc/caddy/Caddyfile
:8080
root * /wwwroot
file_server

@websockets_ring {
header Connection *Upgrade*
header Upgrade    websocket
path /ring
}
reverse_proxy @websockets_ring 127.0.0.1:9090
EOF




# Run V2Ray caddy
caddy run --config /etc/caddy/Caddyfile
