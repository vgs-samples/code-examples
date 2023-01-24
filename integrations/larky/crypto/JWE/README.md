# JWE encryption, decryption and signature

Use-case:
- reading the body
- ecrypting payload
- reading Timestamp from the header
- creating signature
- decrypting payload

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

![image](https://user-images.githubusercontent.com/78090218/214271797-0a621330-8fa9-4b9c-9e05-2441868d357f.png)

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://tntbmt67sc7.sandbox.verygoodproxy.com/post \
 -H 'Content-Type: application/json' \
 -d '{"accountNumber":"4111111111111111","cardBrand":"VISA","cardType":"DEBIT","expirationMonth":"02","expirationYear":"2025","nameOnAccount":"John Doe"}'
```

NOTE: it's required to create the alias in your vault beforehand

Expected response:
```
"json": {
    "accountNumber": "4111111111111111",
    "cardBrand": "VISA",
    "cardType": "DEBIT",
    "expirationMonth": "02",
    "expirationYear": "2025",
    "nameOnAccount": "John Doe"
  }
```
  
