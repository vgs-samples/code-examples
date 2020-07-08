curl https://api.acme.com -k -X POST \\
    -x __ACCESS_CREDENTIALS__@__VAULT_HOST__:8080 \\
    -X POST \\
    -H "Content-type: application/json" \\
    -d '{"ssn": "$VGS_TOKEN"}'
