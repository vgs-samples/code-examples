# Graphql + JSON body

Use-case: when route needs to process JSON body that contains GraphQL query as a string inside a JSON field.

Problem statement: using popular `input.body = builtins.bytes(json.dumps(body))` won't suit because it converts all chars `\n` into newlines (image below). Instead, introducing a good replacement `codecs.encode(json.dumps(body),'utf-8','error', False)`. The result of its usage is shown on the last image on this page (at the bottom).

![image](https://github.com/vgs-samples/code-examples/assets/78090218/02760255-4ebf-4cc2-befe-a22f3743b8d7)

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1643" alt="image" src="https://github.com/vgs-samples/code-examples/assets/78090218/1504a342-9e3e-46f7-8602-0f99d601fd8a">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "query": "\n  mutation AddCard($input: AddCardInput!) {\n    addCard(input: $input) {\n      ...CardInfo\n    }\n  }\n  \n  fragment CardInfo on Card {\n    id\n    userID\n    lastDigits\n    expiryMonth\n    expiryYear\n    cardType\n    verificationStatus\n    createdAt\n  }\n\n",
    "variables":{
      "input":{
        "pan":"4757140000000001",
        "cvv":"123",
        "expiry":{
          "expiryMonth":"12",
          "expiryYear":"25"
        },
        "billingDetails":{
          "email":"homer.simpson@cartoons.com",
          "city":"Springfield",
          "country":"US",
          "name":"Homer Visa",
          "province": "ON",
          "street": "123 Fake Street",
          "zip": "M6K1X1"
        }
      }
    }
}
```

Expected response:
```
"json": {
    "query": "\n  mutation AddCard($input: AddCardInput!) {\n    addCard(input: $input) {\n      ...CardInfo\n    }\n  }\n  \n  fragment CardInfo on Card {\n    id\n    userID\n    lastDigits\n    expiryMonth\n    expiryYear\n    cardType\n    verificationStatus\n    createdAt\n  }\n\n",
    "variables": {
      "input": {
        "billingDetails": {
          "city": "Springfield",
          "country": "US",
          "email": "homer.simpson@cartoons.com",
          "name": "Homer Visa",
          "province": "ON",
          "street": "123 Fake Street",
          "zip": "M6K1X1"
        },
        "cvv": "tok_sandbox_3vLZ4BABiso9ziwzUF7Yz2",
        "expiry": {
          "expiryMonth": "12",
          "expiryYear": "25"
        },
        "pan": "tok_sandbox_i7NMjE9TmueQrWGQmnoHBZ"
      }
    }
  }
```

![image](https://github.com/vgs-samples/code-examples/assets/78090218/8c14d8b6-8fca-47d2-b76b-6a3e27c95700)
