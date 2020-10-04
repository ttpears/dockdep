#! /bin/bash

# Import config

CONFS="eclectic-docker-common.conf radarr.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
  --name=radarr \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -e TZ=$LOCAL_TZ \
  -e UMASK_SET=022 \
  -p 7878:7878 \
  -v ../conf.d/radarr/config:/config \
  -v $MEDIA_VOL/Movies:/movies \
  -v $MEDIA_VOL:/downloads \
  --restart unless-stopped \
  linuxserver/radarr
