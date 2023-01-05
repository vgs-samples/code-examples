# Change Expiration Date format

Use-case: when the 3rd party PSP requires Expiration Date to be in the format MM/YY, but the vault stores either YYYY, YY, MM separately.

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
    "exp_month": "tok_sandbox_asnbhwEnXEYAuT9enzW3Fp",
    "exp_year": "tok_sandbox_23hB4vQyEGRBGcQPxmHwom"
  }'

or

curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "exp_month": "tok_sandbox_asnbhwEnXEYAuT9enzW3Fp",
    "exp_year": "tok_sandbox_vk7w1jtbKgM2jjgzUgchsT"
  }'
```

Expected response:
```
"json": {
    "exp_date": "09/29",
    "vault_month": "09",
    "vault_year": "2029"
  }

or

"json": {
    "exp_date": "09/29",
    "vault_month": "09",
    "vault_year": "29"
  }
```
