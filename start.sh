#!/bin/bash

LIDARR_DIR=$(ls /opt | grep Lidarr*)

if [ $ENABLE_BACKUP = "1" ]; then
  /opt/backup.sh &
fi

mono --debug /opt/$LIDARR_DIR/Lidarr.exe -nobrowser -data=/config
