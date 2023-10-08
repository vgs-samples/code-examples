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

![image](https://github.com/vgs-samples/code-examples/assets/78090218/cd5324de-7db8-40ca-bb26-0bdcfd5c5a5c)

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

![image](https://github.com/vgs-samples/code-examples/assets/78090218/1a4d22a7-06c5-437d-a77c-3ed6488dd690)

![image](https://github.com/vgs-samples/code-examples/assets/78090218/b599aa6d-6e33-4f96-b4cb-d11f3a7d0f19)

