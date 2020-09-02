#!/bin/bash
# sed 's/pattern/replacement/flags'
echo "{\"php\": {\"inbound\": \"$(echo $(php inbound-integration.php) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\", \
 \"outbound\": \"$(echo $(php outbound-integration.php) | sed 's/\\/\\\\/g' | sed 's/"/\\"/g')\"}}" > results.txt