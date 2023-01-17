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

![image](https://user-images.githubusercontent.com/78090218/212858693-3215fe65-586b-443e-9c74-dea8ae9b2150.png)

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

![image](https://user-images.githubusercontent.com/78090218/212858746-e97ee7df-4aab-47f3-b30b-6c3761ec117e.png)
