# SHA1 sample of encryption in Larky

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<img width="1359" alt="image" src="https://user-images.githubusercontent.com/78090218/195982008-f66b312d-fd2a-43ce-9dbb-528a21e56fcb.png">

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
    "message": "e951117c03e65e4ce40ef14d1214178e9a998984"
  }
```
