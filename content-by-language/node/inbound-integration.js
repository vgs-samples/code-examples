const request = require('request');

request(
  {
    url: '{VAULT_URL}/post',
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ secret: 'secret_value' }),
  },
  function(error, response, body) {
    if (error) {
      console.log(error);
    } else {
      console.log('Status:', response.statusCode);
      console.log(JSON.parse(body));
    }
  }
);
