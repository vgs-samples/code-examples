#!/bin/bash
echo "{\"bash\": \
    {\"inbound\": $(bash inbound-integration.sh | jq tostring), \
    \"outbound\": $(bash outbound-integration.sh | jq tostring)}}" > results.txt