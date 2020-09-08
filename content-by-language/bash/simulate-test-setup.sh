curl https://backgroundcheck.yourcompany.com/post -k \\
  -x __VAULT_PROXY_URL__ \\
  -X POST \\
  -H "Content-type: application/json"  \\
  -d '{"ssn": "$VGS_TOKEN"}'
