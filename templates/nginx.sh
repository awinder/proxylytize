#!/bin/bash
RESOLVER_ADDR=$(getent hosts consul.service.consul | awk '{ print $1 }')
sed -i "s/\$RESOLVER/${RESOLVER_ADDR}/" /usr/local/openresty/nginx/conf/nginx.tmpl
sed -i "s/\$RESOLVER/${RESOLVER_ADDR}/" /usr/local/openresty/nginx/conf/nginx.conf

nginx -g "daemon off; error_log /dev/stderr info;"