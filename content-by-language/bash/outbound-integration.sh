curl {VGS_SAMPLE_ECHO_SERVER}/post {IGNORE_SSL_FLAG} \\
  -x {SECURE_PROTOCOL}://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT} \\
  -H "Content-type: application/json" \\
  -d '{"account_number": "{ALIAS}"}'
