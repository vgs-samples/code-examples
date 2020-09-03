#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"java\": {\"inbound\": \"$(echo $(java personalized-inbound-integration.java) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"\"}}" > results.txt
