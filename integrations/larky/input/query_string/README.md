# Reading query string

Use-case:
- reading and parsing the query_string
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

![image](https://user-images.githubusercontent.com/78090218/213140632-33e7d6a3-5599-4bd2-83d1-4765fa340ec0.png)

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
"json": {
    "account": "4111111111111111",
    "amount": "100"
  }
```

![image](https://user-images.githubusercontent.com/78090218/213140697-f4018add-6245-4518-9777-3f4ae8103450.png)
