# json.dumps() + separators

Problem statement: Larky does not provide `separators` in `json.dumps()` out of the box. However, this workaround will help to overcome the issue.

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1638" alt="image" src="https://github.com/vgs-samples/code-examples/assets/78090218/3a12365c-5cbf-4c51-a229-64d7ae253437">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
        "pan":"4242424242424242",
        "cvv":"123",
        "expiry":{
            "expiryMonth":"12",
            "expiryYear":"25"
        }
    }'
```

Expected response:
```
"data": "{\"cvv\": \"123\", \"expiry\": {\"expiryMonth\": \"12\", \"expiryYear\": \"25\"}, \"pan\": \"4242424242424242\"}",
...
"json": {
    "cvv": "123",
    "expiry": {
      "expiryMonth": "12",
      "expiryYear": "25"
    },
    "pan": "4242424242424242"
  },
```

<img width="1269" alt="image" src="https://github.com/vgs-samples/code-examples/assets/78090218/27c75ccd-dc42-4d00-aa47-e1f938f785a2">

