#! /usr/bin/env ruby
# Author: Xan

require 'ipaddr'
require './project_creator'
require 'resolv'

class PortScanEngine
	def initialize(targets)
		@time_now = Time.new
		@time = @time_now.strftime("%Y%m%d_%H%M")
		@port_scan_arg = "-v3 -Pn -T5 -sU -sT"
		@targets = targets
		@dir_root = "data"
		@project = ProjectCreator.new
	end

	def target_resolv()
		data = []
		@targets.each do |target|
			if target =~ /\/[0-9]{1,2}/
				ip_addr = IPAddr.new(target)
				ranges = ip_addr.to_range()
				ranges.each do |range|
					data << range.to_s
				end
			else
				resolvs = Resolv.getaddresses(target)
				resolvs.each do |resolv|
					data << resolv
				end
				data << target
			end
		end
		return data
	end

	def port_detection
		dir_path = "#{@dir_root}/#{__method__}"
		@project.mkdir(dir_path)
		target_resolv.uniq.each do |target|
			file_name = "nmap_port_scan-#{target}-#{@time}"
			file_path = "#{dir_path}/#{file_name}"
			puts "Execution: nmap #{@port_scan_arg} -oX #{file_path}.xml #{target} > #{file_path}"
			`nmap #{@port_scan_arg} -oX #{file_path}.xml #{target} > #{file_path}`
		end
	end
end
