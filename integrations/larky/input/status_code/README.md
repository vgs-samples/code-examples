# Change Expiration Date format

Use-case: when it's required to perform different actions depending on the status code.

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

![image](https://user-images.githubusercontent.com/78090218/210802769-048d89d1-99d0-4159-8d29-57d3dc2007aa.png)

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/status/200 -k \
  -H "Content-type: application/json" \
  -d '{}' -v

or

curl https://VAULT_ID.sandbox.verygoodproxy.com/status/300 -k \
  -H "Content-type: application/json" \
  -d '{}' -v
```

NOTE: the route filter is triggered on RESPONSE when the Path begins with "/status".

Expected response:
```
< HTTP/2 200
< server: nginx
< date: Thu, 05 Jan 2023 13:34:16 GMT
< content-type: text/html; charset=utf-8
< content-length: 0
< access-control-allow-origin: *
< access-control-allow-credentials: true
< via: 1.1 reverse-proxy-k4-02-7cb4cf9457-ckvwm
< x-status: 200 OK
< vgs-request-id: 1e998a5a66ed7a82b8c6efc0947a329f

or

< HTTP/2 300
< server: nginx
< date: Thu, 05 Jan 2023 13:34:29 GMT
< content-type: text/html; charset=utf-8
< content-length: 0
< access-control-allow-origin: *
< access-control-allow-credentials: true
< via: 1.1 reverse-proxy-k4-02-7cb4cf9457-d599n
< x-status: Smth went wrong...
< vgs-request-id: 91352cd00184a1a658ea72f04726efff
```
