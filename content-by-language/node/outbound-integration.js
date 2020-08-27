const fs = require('fs');
const url = require('url');
const fetch = require('node-fetch');
const HttpsProxyAgent = require('https-proxy-agent');
/**
 * NODE_TLS_REJECT_UNAUTHORIZED used to allow self signed certificate
 * setting it to 0 on live environments is insecure
 */
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
const urlParams = url.parse('http://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT}');
const agent = new HttpsProxyAgent({
  ...urlParams,
  ca: [fs.readFileSync('../../mixed-content/sandbox_cert.pem')],
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
