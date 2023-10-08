# Headers capitalization

Larky is sensitive to header names so it is required to refer to the headers (in code) by specifying the exact letter case (upper/lower/camelcase etc).
Below is an example of how this can be managed so the route can deal with/read headers without worrying about the letter case.

Use-case:
- read headers as a dict
- loop through the dict keys
- make each key uppercase and match it to expected name
- do different actions depending on the header name
- produce JSON body with header names keeping the original letter case

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

![image](https://user-images.githubusercontent.com/78090218/214271921-0b0028ba-166d-4704-a5c7-8ee8579438c3.png)

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -H "secret: qwerty" \
  -H "Name: John" \
  -H "CVV: 123" \
  -H "X-Address: 11.22.33.44" \
  -d '{}'
```

Expected response from curl:
```
"json": {
    "cvv": "tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2",
    "name": "Welcome on board John",
    "secret": "********",
    "x-address": "11.22.33.44/24"
  }
```

According to the test above, curl makes all header names in lowercase.

Check also below a sample of the same YAML code result using Postman:

![image](https://user-images.githubusercontent.com/78090218/214271960-9fced90c-3ee9-4886-b9f0-31ba6e469f51.png)

![image](https://user-images.githubusercontent.com/78090218/214271982-5609a5c0-f53e-4a16-a0bb-b58fdee12780.png)


