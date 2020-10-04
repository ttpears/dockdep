#! /bin/bash

# Import config

CONFS="eclectic-docker-common.conf ubooquity.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
  --name=ubooquity \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -e TZ=$LOCAL_TZ \
  -e MAXMEM=1024 \
  -p 2202:2202 \
  -p 2203:2203 \
  -v ../conf.d/ubooquity:/config \
  -v $MEDIA_VOL/Books:/books \
  -v $MEDIA_VOL:/files \
  --restart unless-stopped \
  linuxserver/ubooquity
