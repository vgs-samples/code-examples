curl {VGS_SAMPLE_ECHO_SERVER}/post {IGNORE_SSL_FLAG} \\
  -x {ACCESS_CREDENTIALS}@{VAULT_HOST}:{SECURE_PORT} \\
  -H "Content-type: application/json" \\
  -d '{"account_number": "{ALIAS}"}'
