# Redact SSN from XML payload

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

![image](https://github.com/vgs-samples/code-examples/assets/78090218/02540bfa-3560-4d05-b358-ee209c0fe211)

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.ENV.verygoodproxy.com/post -k \
  -H "Content-type: text/xml" \
  -d@payload.xml
```
The file `payload.xml` is also included into the repo.

Expected response:

![image](https://github.com/vgs-samples/code-examples/assets/78090218/726f64ac-a046-4963-8d08-63a6dde9a7d0)

![image](https://github.com/vgs-samples/code-examples/assets/78090218/e9cebf9b-b585-4f80-b449-0721d18d1d91)
