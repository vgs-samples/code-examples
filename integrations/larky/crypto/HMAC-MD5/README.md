# HMAC-MD5 hash

Use-case:
- reveal of alias in the body
- reading ID from the header
- reveal of the secret key (hardcoded in the code)
- generating the hash
- writing output header

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

![image](https://user-images.githubusercontent.com/78090218/214271603-9cc12ecc-0620-4c60-8180-fb2b9a7a9394.png)

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -H "x-customer-id: 1q2W3e4R5t6Y7u8I9o0P" \
  -d '{"account":"tok_sandbox_a4JULYBMphkeL2iV7ipwdL"}'
```

NOTE: it's required to create the aliases in your vault beforehand

Expected response:
```
"headers": {
    ...
    "X-Customer-Id": "1q2W3e4R5t6Y7u8I9o0P",
    "X-Hash": "cec8313d134368778d8e3ae4b9268ed4"
  },
  "json": {
    "account": "4111111111111111"
  }
```

![image](https://user-images.githubusercontent.com/78090218/214271655-e43a7057-df79-430c-836d-4d99c57440c8.png)
