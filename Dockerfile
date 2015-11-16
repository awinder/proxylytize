FROM awinder/alpine-openresty:1.9.3.1

RUN apk add --update sed make bash curl && rm -rf /var/cache/apk/*

RUN wget https://github.com/pintsized/lua-resty-http/archive/v0.06.tar.gz && \
    tar -zxf v0.06.tar.gz && \
    cd lua-resty-http-0.06 && \
    make install && \
    cd .. && \
    rm v0.06.tar.gz && \
    rm -rf lua-resty-http-0.06
    
WORKDIR /usr/local/bin

RUN wget --no-check-certificate https://releases.hashicorp.com/consul-template/0.11.1/consul-template_0.11.1_linux_amd64.zip && \
    unzip consul-template* && \
    chmod uga+x consul-template && \
    rm consul-template_0.11.1_linux_amd64.zip

WORKDIR /opt/proxylytize

ADD Procfile /opt/proxylytize/Procfile
ADD build/forego /usr/local/bin/forego
ADD templates /opt/proxylytize/templates
ADD nginx/scripts /usr/local/openresty/nginx/scripts

RUN chmod uga+x /usr/local/bin/forego

ENV DOCKER_ADDR http://consul.service.consul:8500
ENV HOST_IP     127.0.0.1
ENV HOST_PORT   80

CMD ["forego", "start"]