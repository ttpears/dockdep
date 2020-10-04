#! /bin/bash

# Import config

CONFS="eclectic-docker-common.conf transmission.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run --cap-add=NET_ADMIN -d \
   --name transmission \
   -v $MEDIA_VOL:/data \
   -v /etc/localtime:/etc/localtime:ro \
   -e PUID=$PUID \
   -e PGID=$GUID \
   -e CREATE_TUN_DEVICE=true \
   -e OPENVPN_PROVIDER=$VPN_PROV \
   -e OPENVPN_CONFIG="$VPN_ENDPOINT" \
   -e OPENVPN_USERNAME="$VPN_USER" \
   -e OPENVPN_PASSWORD="$VPN_PASS" \
   -e WEBPROXY_ENABLED=false \
   -e LOCAL_NETWORK=$LAN_CIDR \
   --log-driver json-file \
   --log-opt max-size=10m \
   -p 9091:9091 \
   haugene/transmission-openvpn
