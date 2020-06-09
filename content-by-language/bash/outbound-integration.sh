curl {VGS_SAMPLE_ECHO_SERVER}/post -k \\
  -x {ACCESS_CREDENTIALS}@{VAULT_HOST}:{PORT} \\
  -H "Content-type: application/json" \\
  -d '{"account_number": "{ALIAS}"}'
