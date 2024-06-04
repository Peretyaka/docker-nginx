#!/bin/sh

if [ "$APP_TYPE" = "spa" ]; then
  mkdir -p /etc/nginx/conf.d/core

  printf "try_files \$uri /index.html =404;" > /etc/nginx/conf.d/core/10-spa.conf;

  echo "SPA configuration is added"
else
  echo "APP_TYPE is not equal spa. SPA configuration is not added."
fi
