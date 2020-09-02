#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"ruby\": {\"inbound\": \"$(echo $(ruby inbound-integration.rb) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(ruby outbound-integration.rb) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt