#! /bin/bash

# Import config

CONFS="eclectic-docker-common.conf plex.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
  --name=plex \
  --net host \
  -e VERSION=docker \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -e UMASK_SET=022 \
  -v ../volumes.d/plex:/config \
  -v $MEDIA_VOL/Movies:/srv/Media/Movies \
  -v $MEDIA_VOL/TvShows:/srv/Media/TvShows \
  -v $MEDIA_VOL/Audio:/srv/Media/Audio \
  --restart unless-stopped \
  linuxserver/plex
