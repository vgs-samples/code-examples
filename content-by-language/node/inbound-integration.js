const axios = require('axios');

async function getData() {
  let result;

  try {
    result = await axios.post('{VAULT_URL}/post', {
      account_number: 'ACC00000000000000000',
    }, {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (e) {
    console.error(e);
  }

  return result.data;
}

getData().then(response => console.log(response));
