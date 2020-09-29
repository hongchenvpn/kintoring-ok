#!/bin/sh

# Download and install V2Ray
mkdir /tmp/v2ray
mkdir -p /usr/local/bin
curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray
mv /tmp/v2ray/v2ray /usr/local/bin/v2ray
mv /tmp/v2ray/v2ctl /usr/local/bin/v2ctl
chmod +x /usr/local/bin/v2ray
chmod +x /usr/local/bin/v2ctl
# Remove temporary directory
rm -rf /tmp/v2ray

cat << EOF > /etc/config.json
{
    "inbounds": 
    [
        {
            "port": 4234,"listen": "127.0.0.1","protocol": "vmess",
            "settings": {"clients": [{"id": "580814c2-a784-44d0-9380-56aa03a7de75", "alterId": 64}]},
            "streamSettings": {"network": "ws", "security": "auto", "wsSettings": {"path": "$V2RAYPATH"}}
        }
    ],
    "outbounds": [{"protocol": "freedom"}]
}	
EOF

# config caddy
mkdir -p /etc/caddy/

cat << EOF > /etc/caddy/Caddyfile
:$PORT
root * /wwwroot
file_server

@websocket_v2ray {
header Connection *Upgrade*
header Upgrade    websocket
path $V2RAYPATH
}
reverse_proxy @websocket_v2ray 127.0.0.1:4234
EOF




# Run V2Ray caddy

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile &
/usr/local/bin/v2ray -config /etc/config.json &
