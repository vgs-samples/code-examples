# Managing query string

Use-case:
- reading and parsing the query_string
- fetching the alias from it
- revealing the alias
- writing the result back to the query_string

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1463" alt="image" src="https://user-images.githubusercontent.com/78090218/213742914-520bcb08-a2db-4271-a228-84c2e08d4a83.png">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl "https://VAULT_ID.sandbox.verygoodproxy.com/post?account=tok_sandbox_a4JULYBMphkeL2iV7ipwdL&amount=100" -k \
  -H "Content-type: application/json" \
  -d '{}'
```

NOTE:
1. It's required to create the alias in your vault beforehand
2. Pay attention that the URL is in quotes "..." (otherwise the curl may be erroring)

Expected response:
```
"json": {},
"url": "https://VAULT_ID.sandbox.verygoodproxy.com/post?account=4111111111111111&amount=100"
```
