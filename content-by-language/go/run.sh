#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"go\": {\"inbound\": \"$(echo $(./inbound-integration) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(./outbound-integration) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt