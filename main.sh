#!/bin/bash
sudo docker-compose build
sudo docker-compose up
(cat content-by-language/bash/results.txt; cat content-by-language/go/results.txt; \
    cat content-by-language/java/results.txt; cat content-by-language/node/results.txt; \
    cat content-by-language/php/results.txt; cat content-by-language/python/results.txt; \
    cat content-by-language/ruby/results.txt) | jq -s add > try_it_results.json
