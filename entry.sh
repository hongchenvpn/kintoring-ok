#!/bin/sh

mkdir -p /tmp/v2ray
mkdir -p /usr/bin/v2ray
curl -L -o "/tmp/v2ray/v2ray.zip" https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip "/tmp/v2ray/v2ray.zip" -d "/usr/bin/v2ray/"
rm -rvf /usr/bin/v2ray/config.json

# config caddy
cat << EOF > /etc/caddy/Caddyfile
:8080
root * /usr/share/caddy
file_server

@websockets_ring {
header Connection *Upgrade*
header Upgrade    websocket
path /ring
}
reverse_proxy @websockets_ring 127.0.0.1:9090
EOF


# V2Ray new configuration
cat << EOF > /usr/bin/v2ray/config.json
{
	"inbounds": {
		"port": "9090",
		"listen": "127.0.0.1",
		"protocol": "vmess",
		"settings": {
			"clients": [ {"id": "580814c2-a784-44d0-9380-56aa03a7de75","alterId": 64} ]
		},
		"streamSettings": {
			"network": "ws",
			"security": "auto",
			"wsSettings": {
				"path": "/ring"
			}
		}
	},
	"outbound": {
		"protocol": "freedom",
		"settings": {}
	},
	"dns": {
		"servers": [ "176.103.130.130", "8.8.8.8", "1.1.1.1", "114.114.114.114"]
	}
}
EOF

chmod +x "/usr/bin/v2ray/v2ray"

# Run V2Ray caddy
nohup caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
/usr/bin/v2ray/v2ray -config /usr/bin/v2ray/config.json
