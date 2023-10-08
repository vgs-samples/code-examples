# Reject request if JSON body is malformed

A good sample of using the `safe` module which can be a good substitution for the `try except` clause.

Flow:
- Try to parse JSON body
- If ok, read the data
- If fail, reject the request

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE OF TEST>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.ENV.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "card_number": "4211424211114242",
  }'
```

Expected response:
```
Operation failed. Request id: 8af945ca82412222b55a2e8466665fb8.
```

<IMAGE CLI>

<IMAGE UI>
