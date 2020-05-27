curl {ENRICHMENT_SNIPPET_URL}
  -k \\
  -x {FORWARD_PROXY_URL_FOR_CURL} \\
  -H "Content-type: application/json" \\
  -d '{"account_number": "ALIAS"}'
