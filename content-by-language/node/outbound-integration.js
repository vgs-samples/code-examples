const fs = require('fs');
const request = require('axios');
const tunnel = require('tunnel');

async function getData() {
  const tunnelingAgent = tunnel.httpsOverHttp({
    ca: [ fs.readFileSync('{CERT_LOCATION}')],
    proxy: {
        host: '{VAULT_HOST}',
        port: '{SECURE_PORT}',
        proxyAuth: '{ACCESS_CREDENTIALS}'
    }
  });

  const redactedPayload = {
    account_number: '{ALIAS}',
  };

  return await request.post(
    '{VGS_SAMPLE_ECHO_SERVER}/post',
    JSON.stringify(redactedPayload),
    {
      httpsAgent: tunnelingAgent,
      proxy: false,
      headers: {
        'Content-Type':'application/json'
      }
  }).then((r) => {
    console.log('\\nResponse from Axios request on REVEAL:');
    console.log(r.data);
    return r.data;
  });
}
