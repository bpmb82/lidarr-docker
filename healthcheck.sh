#!/bin/bash

FILE=/config/config.xml

until test -f $FILE; do sleep 1; done

API=$(xml_grep --text_only 'ApiKey' $FILE)
curl -f "http://localhost:8686/api/v1/system/status?apikey=$API" && curl api.ipify.org || exit 1
