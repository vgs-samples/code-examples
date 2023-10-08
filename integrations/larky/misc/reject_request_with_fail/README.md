# Reject request with bad card number

Use-case: sometimes it is required to reject the request so that it can't go to the upstream. VGS Proxy can't generate a response (to client app) so the possible solution is usage of `fail()` method.

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1399" alt="image" src="https://github.com/vgs-samples/code-examples/assets/78090218/29c6bea2-b965-4f6c-a789-7bb37659823d">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
        "pan":"4716247115929972",
        "cvv":"123",
        "expiry":{
            "expiryMonth":"12",
            "expiryYear":"25"
        }
    }'
```

Expected response:
```
Received error from script engine: This card is blocked in <builtin> at line number 0 at column number 0
Traceback (most recent call last):
  File "larky.star", line 46, column 12, in <toplevel>
  File "larky.star", line 17, column 11, in process
Error in fail: This card is blocked. Request id: 8a19a297bdf81962c68d07af6b7eb8f9.
```

