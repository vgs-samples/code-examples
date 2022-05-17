const fs = require('fs')
const tls = require('tls')
const { curly } = require('node-libcurl')
const {EOL} = require('os');

const certFilePath = '{CERT_LOCATION}'
const ca = '/tmp/vgs-outbound-proxy-ca.pem'
const tlsData = tls.rootCertificates.join(EOL)
const vgsSelfSigned = fs.readFileSync(certFilePath).toString('utf-8')
const systemCaAndVgsCa = tlsData + EOL + vgsSelfSigned;
fs.writeFileSync(ca, systemCaAndVgsCa)

async function run() {
    return curly.post('{VGS_SAMPLE_ECHO_SERVER}/post', {
        postFields: JSON.stringify({ account_number: '{ALIAS}' }),
        httpHeader: ['Content-type: application/json'],
        caInfo: ca,
        proxy: 'https://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{SECURE_PORT}',
        verbose: true,
    })
}

run()
    .then(({ data, statusCode, headers }) =>
        console.log(
            require('util').inspect(
                {
                    data: JSON.parse(data.data),
                    statusCode,
                    headers,
                },
                null,
                4,
            ),
        ),
    )
    .catch((error) => console.error(`Something went wrong`, { error }))