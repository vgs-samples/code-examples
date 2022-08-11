parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

[ ! -f .env ] || export $(grep -v '^#' .env | xargs)

npm install > '/dev/null' 2>&1

correct_response=$(cat ./response.json | jq)
http_response=$(node inbound.js | jq .json)

test "$correct_response" = "$http_response"
