#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"go\": {\"inbound\": \"$(echo $(./personalized-inbound-integration) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(./personalized-outbound-integration) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt
