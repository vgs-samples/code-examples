# Reading and writing the Path

Use-case:
- reading the path
- fetching the alias from it
- revealing the alias
- writing the real CC number into the body
- adjusting the path to fulfill the upstream needs

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
curl https://VAULT_ID.sandbox.verygoodproxy.com/post/account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL \
  -H "Content-type: application/json" \
  -d '{
    "amount": "10"
  }'
```

NOTE: it's required to create the alias in your vault beforehand.

Expected response:
```
"json": {
    "account": "4111111111111111",
    "amount": "10"
  }
```

<IMAGE HERE>
  