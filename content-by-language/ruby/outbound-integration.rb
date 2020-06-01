require 'uri'
require 'json'
require 'net/http'
require 'net/https'

proxy = URI.parse('{FORWARD_PROXY_URL}')
uri = URI.parse('https://echo.apps.verygood.systems/post')
http = Net::HTTP.new(uri.host, uri.port, proxy.host, proxy.port, proxy.user, proxy.password)
http.use_ssl = true
http.ca_file = '/full/path/to/cert.pem'
http.verify_mode = OpenSSL::SSL::VERIFY_PEER
http.verify_depth = 5

request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
request.body = {account_number: '{ALIAS}'}.to_json
response = http.request(request)
puts "Response #{response.code} #{response.message}: #{response.body}"
