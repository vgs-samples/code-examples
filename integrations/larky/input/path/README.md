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

![image](https://user-images.githubusercontent.com/78090218/212858422-6e2f7bed-e8c8-4e25-8a18-e39e4701fc53.png)

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

![image](https://user-images.githubusercontent.com/78090218/212858517-101d510e-9986-4187-81dc-922703d84b69.png)
