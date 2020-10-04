#! /bin/bash

# Import config

CONFS="eclectic-docker-common.conf deluge.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
    --cap-add=NET_ADMIN \
    -p 8112:8112 \
    -p 8118:8118 \
    -p 58846:58846 \
    -p 58946:58946 \
    --name=delugevpn \
    -v $MEDIA_VOL:/downloads \
    -v ../conf.d/deluge/config:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e VPN_ENABLED=$VPN_ENABLED \
    -e VPN_USER=$VPN_USER \
    -e VPN_PASS=$VPN_PASS \
    -e VPN_PROV=$VPN_PROV \
    -e STRICT_PORT_FORWARD=$STRICT_PORT_FORWARD \
    -e ENABLE_PRIVOXY=no \
    -e LAN_NETWORK=$LAN_CIDR \
    -e NAME_SERVERS=$DNS_SERVERS \
    -e DELUGE_DAEMON_LOG_LEVEL=info \
    -e DELUGE_WEB_LOG_LEVEL=info \
    -e DEBUG=false \
    -e UMASK=022 \
    -e PUID=$PUID \
    -e PGID=$GUID \
    binhex/arch-delugevpn
