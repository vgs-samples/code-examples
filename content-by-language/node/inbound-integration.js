const fetch = require('node-fetch');

async function getData() {
  let result;

  try {
    result = await fetch('{VAULT_URL}/post', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        secret: 'secret_value',
      }),
    });
  } catch (e) {
    console.error(e);
  }

  return await result.json();
}

getData().then(response => console.log(response));
