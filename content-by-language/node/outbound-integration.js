// The NODE_EXTRA_CA_CERTS environment variable needs to be set before running the code
// NODE_EXTRA_CA_CERTS=<path_to_sandbox.pem> node outbound.js

const axios = require('axios');
const tunnel = require('tunnel');

const proxyOptions = {
    servername: '{VAULT_HOST}',
    host: '{VAULT_HOST}',
    port: {SECURE_PORT},
    proxyAuth: '{ACCESS_CREDENTIALS}',
};

const agent = tunnel.httpsOverHttps({
    proxy: proxyOptions,
});

const instance = axios.create({
    baseURL: '{VGS_SAMPLE_ECHO_SERVER}',
    headers: {
        'Content-Type': 'application/json',
    },
    httpsAgent: agent,
});

async function run() {
    console.log('Sending POST request via proxy...');
    try {
        const response = await instance.post('/post', {
            account_number: '{ALIAS}',
        });
        console.log('Response data:', response.data);
        return response.data;
    } catch (error) {
        console.error('Error caught during request:', error.message);
        throw error;
    }
}

run().then(() => {
    console.log('Post request via proxy succeeded.');
}).catch(() => {
    console.log('Post request via proxy failed.');
});
