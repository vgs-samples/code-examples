curl https://api.acme.com -k -X POST \\
    -x $HTTPS_PROXY_USERNAME:$HTTPS_PROXY_PASSWORD@$VAULT_ID.sandbox.verygoodproxy.com:8080 \\
    -X POST \\
    -H "Content-type: application/json" \\
    -d '{"ssn": "$VGS_TOKEN"}'