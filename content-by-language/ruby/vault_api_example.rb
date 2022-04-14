#!/usr/bin/env ruby

# Pre-requisites:
#   gem install vgs_api_client
#   gem install dotenv

require 'vgs_api_client'

config = VgsapiClient::Configuration.new

# Optional, the "dotenv" gem, to load these Environment variables from a ".env" file:
require 'dotenv/load'  
config.username = ENV['VAULT_API_USER']
config.password = ENV['VAULT_API_PASS']

vgs_client = VgsapiClient::ApiClient.new(config)
api_client = VgsapiClient::AliasesApi.new(vgs_client)

s = 'A secret message to be stored'
puts "String to be stored: '#{s}'"
puts

puts 'Redact'
puts
data = { value: s, format: 'RAW_UUID'}
message_body = { data: [ data ] }.to_json
response = api_client.create_aliases(debug_body: message_body)
puts "Full response as a Hash:\n#{response.to_hash}\n"
the_alias = response.to_hash[:data].first[:aliases].first[:alias]
puts "Alias created: '#{the_alias}'"
puts

puts 'Reveal:'
puts
response = api_client.reveal_alias(the_alias)
puts "Full response as a Hash:\n#{response.to_hash}\n"
revealed_value = response.to_hash[:data].first[:value]
puts "original value stored: '#{revealed_value}'"
puts

# Delete alias:
puts 'Deleting...'
api_client.delete_alias(the_alias)
puts

puts 'Trying to read it again:'
puts
response = api_client.reveal_alias(the_alias) rescue nil
if response.nil?
  puts "Unable to reveal '#{the_alias}'! Maybe it has been deleted?"
else
  puts "Stored value revealed as a Hash:\n#{response.to_hash}\n"
end
puts


# Example of output:

# String to be stored: 'A secret message to be stored'
#
# Redact
#
# Full response as a Hash:
# {:data=>[{:aliases=>[{:alias=>"72f21a4c-deca-4c8a-ab88-2a4b4a4625ae", :format=>"RAW_UUID"}], :classifiers=>[], :created_at=>2022-03-29 18:04:07 UTC, :value=>"A secret message to be stored"}]}
# Alias created: '72f21a4c-deca-4c8a-ab88-2a4b4a4625ae'
#
# Reveal:
#
# Full response as a Hash:
# {:data=>[{:aliases=>[{:alias=>"72f21a4c-deca-4c8a-ab88-2a4b4a4625ae", :format=>"RAW_UUID"}], :classifiers=>[], :created_at=>2022-03-29 18:04:07 UTC, :value=>"A secret message to be stored"}]}
# original value stored: 'A secret message to be stored'
#
# Deleting...
#
# Trying to read it again:
#
# Unable to reveal '72f21a4c-deca-4c8a-ab88-2a4b4a4625ae'! Maybe it has been deleted?
