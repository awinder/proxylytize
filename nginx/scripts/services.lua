local http = require "resty.http"
local httpc = http:new()

httpc:set_timeout(5000)
local res, err  = httpc:request_uri("http://consul.service.consul:8500/v1/catalog/services", {
    timeout = 10000,
    method = "GET"
})

if not res then
  ngx.log(ngx.ERR, err)
  ngx.status = 500

  ngx.header['Content-Type'] = 'application/json'
  ngx.say('{ "error" : "There was a problem fetching the list of services, please try again."}')
  return
end


if res.status == 200 then    
    ngx.status = 200
    ngx.header['Content-Type'] = 'application/json'
    ngx.say(res.body)
    return
else
    ngx.status = 500
    ngx.header['Content-Type'] = 'application/json'
    ngx.say('{ "error" : "There was a problem fetching the list of services, please try again."}')
    ngx.exit(ngx.OK)
end
