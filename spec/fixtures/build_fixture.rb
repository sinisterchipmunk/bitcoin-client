#!/usr/bin/env ruby

require 'yaml'
require 'json'

service_name = ARGV[0]
file_name = (ARGV[1] || service_name).dup
params = ARGV[2..-1].collect { |y| y == '_nil' ? nil : YAML::load(y) }

file_name << ".json" unless file_name =~ /\.json$/

data = { 'jsonrpc' => '1.0', 'id' => 'curltest', 'method' => service_name, 'params' => params }
command = "curl --user LovleOdnu:NajOij6DriWokEjEinaw --data-binary '#{data.to_json}' -H 'content-type: text/plain;' http://127.0.0.1:8332/ -i"

puts command, nil
result = %x[#{command}]
puts result, nil
File.open(file_name, "w") { |f| f.print result }

