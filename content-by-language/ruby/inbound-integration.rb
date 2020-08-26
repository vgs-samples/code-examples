require 'uri'
require 'json'
require 'net/https'

uri = URI.parse('https://tntsfeqzp4a.sandbox.verygoodproxy.com/post')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
request.body = {account_number: 'ACC00000000000000000'}.to_json
response = http.request(request)
puts "Response #{response.code} #{response.message}: #{response.body}"