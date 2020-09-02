#!/bin/bash
npm install
# sed 's/pattern/replacement/flags'
echo "{\"node\": {\"inbound\": \"$(echo $(node inbound-integration.js) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(node outbound-integration.js) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt