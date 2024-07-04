const axios = require('axios');

const instance = axios.create({
  baseURL: '{VAULT_URL}',
  headers: {
      'Content-Type': 'application/json',
  },
});

async function getData() {
  let result;

  try {
    const response = await instance.post('/post', {
        account_number: 'ACC00000000000000000',
    });
    console.log('Response data:', response.data);
    return response.data;
  } catch (error) {
    console.error('Error caught during request:', error.message);
    throw error;
}
}

getData().then(response => console.log('Post request via proxy succeeded.'));
