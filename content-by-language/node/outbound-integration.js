const fs = require('fs');
const request = require('request');
const tunnel = require('tunnel');

/**
 * NODE_TLS_REJECT_UNAUTHORIZED used to allow self signed certificate
 * setting it to 0 on live environments is insecure
 */
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

const tunnelingAgent = tunnel.httpsOverHttp({
  ca: [ fs.readFileSync('path/to/cert.pem')],
  proxy: {
    host: '{vaultIdentifier}.sandbox.verygoodproxy.com',
    port: 8080,
    proxyAuth: '{username}:{password}'
  }
});

request({
  url: 'https://echo.apps.verygood.systems/post',
  method: 'POST',
  headers: {'Content-Type': 'application/json'},
  agent: tunnelingAgent,
  body: JSON.stringify({'secret' : 'ALIAS'})
}, function(error, response, body){
  if(error) {
    console.log(error);
  } else {
    console.log('Status:', response.statusCode);
    console.log(JSON.parse(body));
  }
});
