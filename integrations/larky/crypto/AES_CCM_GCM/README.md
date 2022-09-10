# AES CCM and GCM sample of encryption in Larky

This sample includes:
1. Python script that generates an ectrypted message of an input data;
2. Larky test `.star` file that generates the same result of the same input data;
3. Ready-for-use YAML (Inbound Route) that produces the same result as previous scripts.

## Testing part:

#### 1. Python:

Python script includes all hard-coded inside. As a result, it prints the encrypted message:
```
$ python python_sample.py

>>> Encrypted GCM:  YXNkNDU2ZmdoMDEyql2O8UB53Ux94KWoIaIDarnm+6xKaXL2FNfHl5XOCtbv590W5x6ISEI3

>>> GCM decrypted: b'{"card_number":"4111111111111111"}'

>>> Encrypted CCM:  YXNkNDU2ZmdoMDEysNf+zbjlTcFG/q1TPyuLIJwELXp6pSwIx1bwpV8Zw92S6G2FpI3OpWEJ

>>> CCM decrypted: b'{"card_number":"4111111111111111"}'

```

#### 2. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1364" alt="image" src="https://user-images.githubusercontent.com/78090218/189484115-04cfb575-f39c-4e55-9f9e-1d0095650e63.png">

#### 3. YAML file:

Upload the YAML to your vault and run:
```
curl https://tntbmt67sc7.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{"card_number":"4111111111111111"}'
```

Example of response:
```
"json": {
    "CCM": "YXNkNDU2ZmdoMDEysNf+zbjlTcFG/q1TPyuLIJwELXp6pSwIx1bwpV8Zw92S6G2FpI3OpWEJ",
    "CCM_decrypted": {
      "card_number": "4111111111111111"
    },
    "GCM": "YXNkNDU2ZmdoMDEyql2O8UB53Ux94KWoIaIDarnm+6xKaXL2FNfHl5XOCtbv590W5x6ISEI3",
    "GCM_decrypted": {
      "card_number": "4111111111111111"
    }
```
