# Biulding full URL

Use-case: sometimes it is required to build a complete URL and send it e.g. as a header

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Outbound Route) that produces the same result as Larky test.

Legend:
```
protocol = input.url       # returns 'https://'
host = headers['Host']     # returns 'VAULT_ID.sandbox.verygoodproxy.com' for Inbound Route
                           # and 'echo.apps.verygood.systems' for Outbound Route (i.e. upstream)
path = input.path          # returns '/post'
query = input.query_string # returns 'account=homer'
```

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl 'https://echo.apps.verygood.systems/post?account=homer' -k \
  -x "https://USERNAME:PASSWORD@VAULT_ID.sandbox.verygoodproxy.com:8443" \
  -H "Content-type: application/json" \
  -d ''
```

Expected response:
```
"headers": {
    "Accept": "*/*",
    ...
    "X-Request-Uri": "https://echo.apps.verygood.systems/post?account=homer"
  }
```

<IMAGE>
