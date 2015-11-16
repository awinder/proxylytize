# proxylytize

Consul HTTP proxy based on tagged services

## Build Instructions

```
chmod +x build/build-forego.sh && ./build/build-forego.sh
docker build -t awinder/proxylytize:latest .
```

## Running Instructions

```
docker run -d --net=host -p 8400:8400 -p 8500:8500 -p 8600:53/udp progrium/consul -server -bootstrap -ui-dir /ui -advertise 10.211.55.23 -bind 10.211.55.23
docker run --dns=10.211.55.23 --env HOST_IP=10.211.55.23 --env HOST_PORT=5000 -p 5000:80 awinder/proxylytize
```

These instructions assume:

* A host with ip of **10.211.55.23** which is running Consul DNS as well as the proxy service
  * Change where appropriate, no issue if your Consul DNS and Host for the proxy are different
* That you want to run the proxy service on port **5000**
