curl https://backgroundcheck.yourcompany.com/post -k \\
  -x $YOUR_PROXY \\
  -X POST \\
  -H "Content-type: application/json"  \\
  -d '{"ssn": "$VGS_TOKEN"}'
