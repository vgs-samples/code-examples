const fs = require('fs');
const tls = require('tls');
const axios = require('axios');
const { EOL } = require('os');
const https = require('https');

// Paths to certificate files
const certFilePath = '{CERT_LOCATION}';
const caFilePath = '/tmp/vgs-outbound-proxy-ca.pem';

// Read and combine system root certificates with the VGS self-signed certificate
const tlsData = tls.rootCertificates.join(EOL);
const vgsSelfSigned = fs.readFileSync(certFilePath).toString('utf-8');
const combinedCa = tlsData + EOL + vgsSelfSigned;
fs.writeFileSync(caFilePath, combinedCa);

// Create an HTTPS agent with the combined CA certificates
const httpsAgent = new https.Agent({
  ca: combinedCa,
});

async function run() {
  try {
    const response = await axios.post(
      '{VGS_SAMPLE_ECHO_SERVER}/post',
      { account_number: '{ALIAS}' },
      {
        headers: { 'Content-Type': 'application/json' },
        proxy: {
          protocol: 'https',
          host: '{VAULT_HOST}',
          port: {SECURE_PORT},
          auth: {
            username: '{USERNAME}',
            password: '{PASSWORD}',
          },
        },
        httpsAgent: httpsAgent,
      }
    );

    console.log(
      require('util').inspect(
        {
          data: response.data,
          statusCode: response.status,
          headers: response.headers,
        },
        null,
        4
      )
    );
  } catch (error) {
    console.error(`Something went wrong`, { error });
  }
}

run();
