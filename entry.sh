#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
install -m 755 /tmp/v2ray/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
# Remove temporary directory
rm -rf /tmp/v2ray

cat << EOF > /etc/config.json
{
	"inbounds": {
		"port": "9090",
		"listen": "127.0.0.1",
		"protocol": "vmess",
		"settings": {
			"clients": [ 
			    {
			        "id": "580814c2-a784-44d0-9380-56aa03a7de75",
			        "alterId": 64
			    }
			]
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


# config caddy
mkdir -p /etc/caddy/

cat << EOF > /etc/caddy/Caddyfile
:$PORT
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
/usr/local/bin/v2ray -config /etc/config.json &
caddy run --config /etc/caddy/Caddyfile
