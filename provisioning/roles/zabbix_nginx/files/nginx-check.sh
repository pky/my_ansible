#!/bin/bash

ZBX_REQ_DATA="$1"

URL="http://localhost:10064/nginx_status"
CURL_BIN="/usr/bin/curl"

NGINX_STATS=$($CURL_BIN $URL 2>/dev/null)

if [ $? -ne 0 -o -z "$NGINX_STATS" ]; then
  echo 1
  exit 1
fi

case $ZBX_REQ_DATA in
  active_connections)   echo "$NGINX_STATS" | head -1             | cut -f3 -d' ';;
  accepted_connections) echo "$NGINX_STATS" | grep -Ev '[a-zA-Z]' | cut -f2 -d' ';;
  handled_connections)  echo "$NGINX_STATS" | grep -Ev '[a-zA-Z]' | cut -f3 -d' ';;
  handled_requests)     echo "$NGINX_STATS" | grep -Ev '[a-zA-Z]' | cut -f4 -d' ';;
  reading)              echo "$NGINX_STATS" | tail -1             | cut -f2 -d' ';;
  writing)              echo "$NGINX_STATS" | tail -1             | cut -f4 -d' ';;
  waiting)              echo "$NGINX_STATS" | tail -1             | cut -f6 -d' ';;
  *) echo $ERROR_WRONG_PARAM; exit 1;;
esac

exit 0
