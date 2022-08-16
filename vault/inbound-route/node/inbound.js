const fetch = require('node-fetch');

const { VAULT_ID } = process.env;
const vaultUrl = `https://${VAULT_ID}.sandbox.verygoodproxy.com`;

async function getData() {
  let result;

  try {
    result = await fetch(`${vaultUrl}/post`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        account_number: 'ACC00000000000000000',
      }),
    });
  } catch (e) {
    console.error(e);
  }

  return await result.text();
}

getData().then(console.log);
