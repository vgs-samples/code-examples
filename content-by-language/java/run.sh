#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"java\": {\"inbound\": \"$(echo $(java personalized-inbound-integration.java) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(java -Djdk.http.auth.tunneling.disabledSchemes="" personalized-outbound-integration.java) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt
