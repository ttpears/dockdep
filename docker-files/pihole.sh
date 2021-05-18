#!/bin/bash

# Make sure the following are defined in conf.d/pihole.conf
# 
# EXT_IP - External IP of network pihole will serve

# Import config
CONFS="dockdep-docker-common.conf pihole.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
    --name pihole \
    -p 53:53/tcp -p 53:53/udp \
    -p 80:80 \
    -p 443:443 \
    -e TZ="$LOCAL_TZ" \
    -e PUID=$PUID \
    -e PGID=$GUID \
    -v "../volumes.d/pihole/etc-pihole/:/etc/pihole/" \
    -v "../volumes.d/pihole/etc-dnsmasq.d/:/etc/dnsmasq.d/" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    --restart=unless-stopped \
    --hostname pi.hole \
    -e VIRTUAL_HOST="pi.hole" \
    -e PROXY_LOCATION="pi.hole" \
    -e ServerIP="$EXT_IP" \
    pihole/pihole:latest
