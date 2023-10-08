# Redact card number and keep last four

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE TEST>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.ENV.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "card_number": "4211424211114242"
  }'
```

Expected response:
```
"json": {
    "card_number": "tok_sandbox_kBGVaGSXxXbyDpauaUDosR",
    "last_four": "4242"
  }
```

<IMAGE CLI>

<IMAGE UI>
