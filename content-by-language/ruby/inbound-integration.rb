require 'uri'
require 'json'
require 'net/https'

uri = URI.parse('{REVERSE_PROXY}/post')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
request.body = {account_number: 'account_value'}.to_json
response = http.request(request)
puts "Response #{response.code} #{response.message}: #{response.body}"
