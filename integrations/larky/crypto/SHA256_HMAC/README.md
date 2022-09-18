# SHA256 + HMAC sample of encryption in Larky

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1365" alt="image" src="https://user-images.githubusercontent.com/78090218/190900870-7bb2c66c-ec46-41ee-b54a-0463fb174fb8.png">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://tntbmt67sc7.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -H "X-Key-Id: 17a61221-d72d-fd43-bf45-dae4e13befe5" \
  -H "X-Secret-Key: xy6yBM2J/1LjPGTmcuHtk+GaJrkPp+UYe25fUX6/LtE=" \
  -H "V-C-MERCHANT-ID: testrest" \
  -H "X-Host: apitest.psp.com" \
  -H "Date: Sun, 18 Sep 2022 10:59:14 GMT" \
  -d '{"paymentInformation":{"card": {"expirationMonth":"12","expirationYear":"2030","number":"4242424242424242","securityCode":"321","type":"002"}}}'
```

Expected response:
```
"headers": {
...
    "Date": "Sun, 18 Sep 2022 10:59:14 GMT",
    "Digest": "SHA-256=oLAIBV+UuDeuXx4PUV8WtDHG5y+93dWOnYGCUxmXsX4=",
    "Signature": "keyid=\"17a61221-d72d-fd43-bf45-dae4e13befe5\",algorithm=\"HmacSHA256\",headers=\"x-host date (request-target) digest v-c-merchant-id\",signature=\"KtTlw8mTHAxr3dxZZAksjpgx2eZhOpYODIssbbYfdHE=\"",
    "V-C-Merchant-Id": "testrest",
    "X-Host": "apitest.psp.com"
  }
"json": {
    "encrypted": "true"
  }
```
