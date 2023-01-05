# Change SSN format

Use-case: when the 3rd party PSP requires SSN to be in the format ###-##-####, but the vault stores ######### (without '-').

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE HERE>

#### 2. YAML file:

Upload the YAML to your vault and run (aliases have to be pre-generated in your vault beforehand):
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "ssn": "tok_sandbox_hVSjiJJsA6a9VcAci7wo7g"
  }'
```

Expected response:
```
"json": {
    "ssn": "123-45-6789",
    "vault-ssn": "123456789"
  }
```
