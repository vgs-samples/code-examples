# Delete alias

Flow:
- If body.action is `reveal`, running `vault.reveal()`
- If body.action is `delete`, running `vault.delete()`

This sample includes:
1. Larky test `.star` file that generates the same result due to static input values;
2. Ready-for-use YAML (Inbound Route) that produces the same result as Larky test.

## Testing part:

#### 1. Larky test:

To be able to run Larky locally, you'll need to setup your local environment:
https://www.verygoodsecurity.com/docs/larky/test-larky-locally

Example of run:

<IMAGE OF TEST>

#### 2. YAML file:

Upload the YAML to your vault and run:
```
curl https://VAULT_ID.ENV.verygoodproxy.com/post -k \
  -H "Content-type: application/json" \
  -d '{
    "card_number": "tok_sandbox_3WzYFdMZSn7Xa99oceLwdD",
    "action": "delete"
  }
```

Expected response:
```
"json": {
    "action": "delete",
    "card_number": "deleted"
  }
```

If to run the same command again, the response will be:
```
Received error from script engine: net.starlark.java.eval.Starlark$UncheckedEvalException: RedactionCommonsException thrown during Starlark evaluation. Request id: ed8babff5de73979cd5ff73b24981bdb.
```


<IMAGE CLI>

<IMAGE UI>
