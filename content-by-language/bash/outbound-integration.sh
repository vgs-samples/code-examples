curl {enrichmentSnippetURL}
  -k \\
  -x {forwardProxyURLForCURL} \\
  -H "Content-type: application/json" \\
  -d '{"account_number": "ALIAS"}'
