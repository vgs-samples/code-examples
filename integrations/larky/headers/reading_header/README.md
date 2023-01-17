# Reading header

Use-case:
- reading the header
- revealing the alias
- writing the real secret into the body
- removing the header

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE HERE>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post \
  -H "Content-type: application/json" \
  -H "Secret: tok_sandbox_kqRvua3pGhpP5V2GK2yxL" \
  -d '{}'
```

NOTE: it's required to create the alias in your vault beforehand

Expected response:
```
"json": {
    "secret": "v3ry-53cr3t-w0rd!"
  }
```

<IMAGE HERE>
  