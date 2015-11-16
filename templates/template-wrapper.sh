#!/bin/bash
sleep 1

CONSUL_ADDR=$CONSUL_ADDR || "consul.service.consul:8500"

consul-template \
  -consul consul.service.consul:8500 \
  -template "/usr/local/openresty/nginx/conf/nginx.tmpl:/usr/local/openresty/nginx/conf/nginx.conf:nginx -s reload" \
  -template "/opt/proxylytize/templates/service.json.tmpl:/tmp/proxy-services.json:/opt/proxylytize/templates/refresh-consul.sh" \
  -retry 30s