#! /bin/bash

# Import config

CONFS="dockdep-docker-common.conf sonarr.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
  --name=sonarr \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -e TZ=$LOCAL_TZ \
  -e UMASK_SET=022  \
  -p 8989:8989 \
  -v ../volumes.d/sonarr/config:/config \
  -v $MEDIA_VOL/TvShows:/tv \
  -v $MEDIA_VOL:/downloads \
  --restart unless-stopped \
  linuxserver/sonarr
