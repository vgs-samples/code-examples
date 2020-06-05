curl {VGS_SAMPLE_ECHO_SERVER}/post -k \\
  -x {ACCESS_CREDENTIALS}@{VAULT_IDENTIFIER}.sandbox.verygoodproxy.com:8080 \\
  -H "Content-type: application/json" \\
  -d '{"account_number": "{ALIAS}"}'
