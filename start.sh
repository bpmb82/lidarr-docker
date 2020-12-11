#!/bin/bash

LIDARR_DIR=$(ls | grep Lidarr*)

mono --debug /opt/$LIDARR_DIR/NzbDrone.exe -nobrowser -data=/config
