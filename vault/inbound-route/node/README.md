# Using Inbound Route with Node.js

## Overview
This example sends a request to inbound route.
You may read more about inbound routes [here](https://www.verygoodsecurity.com/docs/vault/concepts/proxies-and-routing-data#inbound-http-routes).

## How to use

Make sure to set your vault id in `.env` file.
```bash
export VAULT_ID=<vault id>
```

then, import route using `inbound-route.yaml` file. You may do this on the [Vault Dashboard](https://dashboard.verygoodsecurity.com) or using the [CLI](https://www.verygoodsecurity.com/docs/vgs-cli/getting-started).

and install dependencies:
```bash
npm install
```

and run the example:
```bash
node inbound.js
```
