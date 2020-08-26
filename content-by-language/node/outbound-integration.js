const fs = require('fs');
const url = require('url');
const fetch = require('node-fetch');
const HttpsProxyAgent = require('https-proxy-agent');
/**
 * NODE_TLS_REJECT_UNAUTHORIZED used to allow self signed certificate
 * setting it to 0 on live environments is insecure
 */
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
const urlParams = url.parse('http://USiyQvWcT7wcpy8gvFb1GVmz:2b48a642-615a-4b3c-8db5-e02a88147174@tntsfeqzp4a.sandbox.verygoodproxy.com:8080');
const agent = new HttpsProxyAgent({
  ...urlParams,
  ca: [fs.readFileSync('../../mixed-content/sandbox_cert.pem')],
});
async function getData() {
  let result;
  try {
    result = await fetch('https://echo.apps.verygood.systems/post', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        account_number: 'tok_sandbox_w8CBfH8vyYL2xWSmMWe3Ds',
      }),
      agent,
    });
  } catch (e) {
    console.error(e);
  }
  return await result.text();
}
getData().then(response => console.log(response));