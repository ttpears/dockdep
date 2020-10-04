#! /bin/bash

# Import config

CONFS="eclectic-docker-common.conf ombi.conf"
for c in $CONFS ; do 
   if [ -f "../conf.d/$c" ]; then
      . ../conf.d/$c
   else
      echo "Missing config: $c, please configure according to samples"
   fi
done

docker run -d \
  --name=ombi \
  -e PUID=$PUID \
  -e PGID=$GUID \
  -e TZ=$LOCAL_TZ \
  -p 3579:3579 \
  -v ../conf.d/ombi/config:/config \
  --restart unless-stopped \
  linuxserver/ombi
