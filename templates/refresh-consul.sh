#!/bin/bash

curl -XPUT "http://consul.service.consul:8500/v1/agent/service/deregister/proxylytize"
curl -XPUT "http://consul.service.consul:8500/v1/agent/service/register" -d @/tmp/proxy-services.json