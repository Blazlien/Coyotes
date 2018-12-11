#! /usr/bin/env ruby
# Author: Xan

require './parser'

class Report
	def initialize()
		@time_now = Time.new
		@time = @time_now.strftime("%Y%m%d_%H%M")
		@targets = Parser.new.parser
		@ips = @targets.keys
		@ports = @targets.values
		@dir_root = "data"
	end

	def port_scan
		file_name = "#{@dir_root}/Report_#{@time}"
	
		@ips.each do |ip|
			ip = ip[0]
			@ports = @targets[[ip]]
			port = @ports.map { |i| i.join(':') }.join(',')
			data = "#{ip}\t#{port}\n"
			File.open(file_name, 'a+') { |file| file.write(data) }
		end
	end
end

report = Report.new
report.port_scan
