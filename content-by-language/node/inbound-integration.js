const fetch = require('node-fetch');

async function getData() {
  let result;

  try {
    result = await fetch('{VAULT_URL}/post', {
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

getData().then(response => console.log(response));
