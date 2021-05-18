#! /bin/bash

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
  --name=jackett \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -e TZ=$LOCAL_TZ \
  -e AUTO_UPDATE=true `#optional` \
  -p 9117:9117 \
  -v ../volumes.d/jackett/config:/config \
  -v $MEDIA_VOL:/downloads \
  --restart unless-stopped \
  linuxserver/jackett
