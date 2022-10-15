# PKCS1_OAEP sample of encryption and decryption in Larky

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H 'Content-Type: application/json' \
  -d '{
    "message": "decrypt me if you can"
    }'
```

NOTE: there is a need to replace the aliases in YAML to your own. Check how to alias keys at:
https://www.verygoodsecurity.com/docs/larky/encryption-keys#preparing-encryption-keys

Expected response:
```
"json": {
    "message": "decrypt me if you can",
    "message_decrypted": "decrypt me if you can"
  }
```
