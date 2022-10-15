# MD5 hash sample in Larky

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1365" alt="image" src="https://user-images.githubusercontent.com/78090218/195981392-eb3d1ca5-2638-4be3-bb39-d34e76b03ef0.png">

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.sandbox.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{"message": "4242424242424242"}'
```

Expected response:
```
"json": {
    "hash": "9b8a421bff5f30d20f118185eb6e4523"
  }
```
