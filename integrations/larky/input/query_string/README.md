# Reading query string

Use-case:
- reading the query string
- fetching the alias from it
- revealing the alias
- writing the real CC number into the body
- writing the original query string and path for demonstration purposes

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
curl "https://VAULT_ID.sandbox.verygoodproxy.com/post?account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL" \
  -H "Content-type: application/json" \
  -d '{
    "amount": "10"
  }'
```

NOTE:
1. It's required to create the alias in your vault beforehand
2. Pay attention that the URL is in quotes "..." (otherwise the curl may be erroring)

Expected response:
```
"json": {
    "account": "4111111111111111",
    "amount": "10",
    "path": "/post",
    "query": "account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL"
  }
```

<IMAGE HERE>
  