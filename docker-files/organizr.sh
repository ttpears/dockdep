#! /bin/bash

# Import config

CONFS="dockdep-docker-common.conf organizr.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
  --name=organizr \
  -v ../volumes.d/organizr/config:/config \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -p 7550:80 \
  --restart unless-stopped \
  organizrtools/organizr-v2
