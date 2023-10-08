# Modifying X-Forwarded-For header

Sometimes it's required to hide presence of the Proxy in the middle by erasing all the IPs that are being added to the X-Forwaded-For header.

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<LARKY TEST IMAGE HERE>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://tntbmt67sc7.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "card_number": "4211424211114242"
  }'
```

<IMAGE FROM UI>
