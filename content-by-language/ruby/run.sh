#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"ruby\": {\"inbound\": \"$(echo $(ruby personalized-inbound-integration.rb) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(ruby personalized-outbound-integration.rb) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt
