# PKCS1_v1.5 sample of encryption and decryption in Larky

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1363" alt="image" src="https://user-images.githubusercontent.com/78090218/193460229-f382dbb8-dc2d-4068-a43e-2ffd5eb24a57.png">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{"card_number": "tok_sandbox_a4JULYBMphkeL2iV7ipwdL", "exp_date": "1234"}'
```

NOTE: there is a need to replace the aliases in YAML to your own. Check how to alias keys at:
https://www.verygoodsecurity.com/docs/larky/encryption-keys#preparing-encryption-keys

Expected response:
```
"json": {
    "card_number": "tok_sandbox_a4JULYBMphkeL2iV7ipwdL",
    "decrypted_card": "4111111111111111",
    "decrypted_date": "1234",
    "exp_date": "1234"
  }
```
