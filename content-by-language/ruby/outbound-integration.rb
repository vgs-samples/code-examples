# We recommend using the 'curb' library because the default
# net/http library does not support connecting to a proxy using TLS.
require 'curb'
require 'json'

proxy = 'https://{ACCESS_CREDENTIALS}@{VAULT_HOST}:{SECURE_PORT}'
uri = '{VGS_SAMPLE_ECHO_SERVER}/post'

c = Curl::Easy.new(uri) do |http|
  http.headers["Content-Type"] = "application/json"
  http.cacert = '{CERT_LOCATION}'
  http.proxy_url = proxy
  http.ssl_verify_peer = true
  http.post_body = {account_number: '{ALIAS}'}.to_json
  http.post
end

puts "Response #{c.status}: #{c.body}"
