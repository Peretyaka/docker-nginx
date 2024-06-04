#!/bin/sh
echo "$DISALLOW_ROBOTS";
if [ "$DISALLOW_ROBOTS" = 1 ]; then
  mkdir -p /etc/nginx/conf.d/server

  printf "location /robots.txt { return 200 \"User-agent: *\\nDisallow: /\"; }" > /etc/nginx/conf.d/server/10-robots-txt.conf;

  echo "robots.txt configuration is added"
else
  echo "DISALLOW_ROBOTS is not equal 1. robots.txt configuration is not added."
fi
