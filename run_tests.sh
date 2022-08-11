#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

for file in $(find "." -type f -name "test.sh")
do
  echo -n "Running tests in $file... "
  chmod +x $file

  sh $file

  if [ $? -eq 0 ]; then
    echo "OK"
  else
    echo -e "${RED}failed${NC}"
    exit 1
  fi
done