#!/bin/bash
npm install
# sed 's/pattern/replacement/flags'
echo "{\"node\": {\"inbound\": \"$(echo $(node personalized-inbound-integration.js) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(node personalized-outbound-integration.js) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt
