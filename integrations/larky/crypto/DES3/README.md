# DES3 sample of encryption in Larky

This sample includes:
1. Python script that generates an ectrypted message of an input data;
2. Larky test `.star` file that generates the same result of the same input data;
3. Ready-for-use YAML (Inbound Route) that produces the same result as previous scripts.

## Testing part:

#### 1. Python:

Python script includes all hard-coded inside. As a result, it prints the encrypted message:
```
$ python python_sample.py
>>> payload:  {'PBFPubKey': 'TSTPUBK-4d1e634d904ededaf0b635d5a0a2f06d-X', 'client': 'qQ+twU0rNrAH14RHqoKqIcIVC/z796bp7uYEvop+gb0C72H9c/jeGwbXwp9Ibqe0GMAj7IErTZ0znvZAeIn6iJPr+LU/qmhLjt1MEYVhwXWMfZdfV3M4DF4m/RWBipZhzNSpHxcaSBjdDOK5kJtkSpCvonb+4p+mf6ND+Yb2R0gXyXDYsTIlVSA2ZWt3bsbok0XOJnSUCWmj8qiJig0L3j3NTHOjuOqH/owcQZpcUFzdbiUmg9aZ9wnU03OZnMF48ICBaYsqkPA5HlWCiWNxu2mhSf6uZZLzB5k74lmiBiJlrnbG9SJ8e9LtebmmN5DVY7f3xGj5xPH5uQNQysvh0gpl90LfHspWPL4L0TBNim3z1GKuEEGxoRF8mz2dFitsVf3aJP/FNlwe4aTTQuCK4fweyZfmbtMD', 'alg': '3DES-24'}
```

#### 2. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1366" alt="image" src="https://user-images.githubusercontent.com/78090218/193454114-5654c57d-6156-4af6-bb3d-ff4f6c115166.png">

#### 3. YAML file:

Upload the YAML to your vault and run (secret here is not real, it was generated by randomizer):
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{"PBFPubKey": "TSTPUBK-4d1e634d904ededaf0b635d5a0a2f06d-X", "cardno": "5438898014560229", "cvv": "890", "expirymonth": "09", "expiryyear": "23", "currency": "USD", "country": "US", "suggested_auth": "cpin", "pin": "3310", "amount": "100", "email": "john.wick@domain.com", "firstname": "John", "lastname": "Wick"}'
```

Example of response:
```
"json": {
    "PBFPubKey": "TSTPUBK-4d1e634d904ededaf0b635d5a0a2f06d-X",
    "alg": "3DES-24",
    "client": "qQ+twU0rNrAH14RHqoKqIcIVC/z796bp7uYEvop+gb0C72H9c/jeGwbXwp9Ibqe0GMAj7IErTZ0znvZAeIn6iJPr+LU/qmhLjt1MEYVhwXWMfZdfV3M4DF4m/RWBipZhzNSpHxcaSBjdDOK5kJtkSpCvonb+4p+mf6ND+Yb2R0gXyXDYsTIlVSA2ZWt3bsbok0XOJnSUCWmj8qiJig0L3j3NTHOjuOqH/owcQZpcUFzdbiUmg9aZ9wnU03OZnMF48ICBaYsqkPA5HlWCiWNxu2mhSf6uZZLzB5k74lmiBiJlrnbG9SJ8e9LtebmmN5DVY7f3xGj5xPH5uQNQysvh0gpl90LfHspWPL4L0TBNim3z1GKuEEGxoRF8mz2dFitsVf3aJP/FNlwe4aTTQuCK4fweyZfmbtMD"
  }
```