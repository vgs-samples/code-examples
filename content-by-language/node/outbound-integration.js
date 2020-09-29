const fs = require('fs');
const url = require('url');
const fetch = require('node-fetch');
const HttpsProxyAgent = require('https-proxy-agent');
const urlParams = url.parse('http://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT}');
const agent = new HttpsProxyAgent({
  ...urlParams,
  ca: [fs.readFileSync('{CERT_LOCATION}')],
});
async function getData() {
  let result;
  try {
    result = await fetch('{VGS_SAMPLE_ECHO_SERVER}/post', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        account_number: '{ALIAS}',
      }),
      agent,
    });
  } catch (e) {
    console.error(e);
  }
  return await result.text();
}
getData().then(response => console.log(response));
