#! /usr/bin/env ruby
# Author: Xan

require './parser'

def hash_to_string
	time_now = Time.new
	time = time_now.strftime("%Y%m%d_%H%M")
	targets = parser()
	ips = targets.keys
	ports = targets.values
	file_name = "ip_address_and_port-#{time}"
	data = []

	ips.each do |ip|
		ip = ip[0]
		ports = targets[[ip]]
		port = ports.map { |i| i.join(':') }.join(',')
		data = "#{ip}\t#{port}\n"
		File.open(file_name, 'a+') { |file| file.write(data) }
	end
end

hash_to_string
