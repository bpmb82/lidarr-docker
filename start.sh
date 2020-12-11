#!/bin/bash

LIDARR_DIR=$(ls /opt | grep Lidarr*)

mono --debug /opt/$LIDARR_DIR/NzbDrone.exe -nobrowser -data=/config
