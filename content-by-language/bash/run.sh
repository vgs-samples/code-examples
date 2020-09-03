#!/bin/bash
echo "{\"bash\": \
    {\"inbound\": $(bash personalized-inbound-integration.sh | jq tostring), \
    \"outbound\": $(bash personalized-outbound-integration.sh | jq tostring)}}" > results.txt
