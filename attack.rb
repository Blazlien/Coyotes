#! /usr/bin/env ruby
# Author: Xan

require './parser'
require './project_creator'
require 'uri'
require 'net/http'

class AttackEngine
	def initialize()
		@time_now = Time.new
		@time = @time_now.strftime("%Y%m%d_%H%M")
		@port_scan_arg = "-v3 -Pn -T5 -A"
		@targets = Parser.new.parser
		@ips = @targets.keys
		@ports = @targets.values
		@dir_root = "data"
		@project = ProjectCreator.new
	end

	def banner_gathering
		dir_path = "#{@dir_root}/#{__method__}"
		@project.mkdir(dir_path)
		@ips.each do |ip|
			port_array = []
			ip = ip[0]
			ports = @targets[[ip]]
			ports.each do |port|
				if port[0] == "tcp"
					port_array << [port[0].gsub(/tcp/, "T:"), port[1]]
				elsif port[0] == "udp"
					port_array << [port[0].gsub(/udp/, "U:"), port[1]]
				end
			end

		port_arg = port_array.join(",").gsub(/:,/, ":")
		file_name = "get_banner-#{ip}-#{@time}"
		file_path = "#{dir_path}/#{file_name}"
	
		p "Execution: nmap #{@port_scan_arg} -p #{port_arg} -oX #{file_path}.xml #{ip} > #{file_path}"
		`nmap #{@port_scan_arg} -p #{port_arg} -oX #{file_path}.xml #{ip} > #{file_path}`
		end
	end

	def nikto
		dir_path = "#{@dir_root}/#{__method__}"
		@project.mkdir(dir_path)
		@ips.each do |ip|
			port_array = []
			ip = ip[0]
			ports = @targets[[ip]]
			ports.each do |port|
				if port[0] == "tcp"
					port_array << port[1]
				end
			end
			port_arg = port_array.join(",")
			file_name = "nikto-#{ip}-#{@time}"
			file_path = "#{dir_path}/#{file_name}"
			p "Execution: nikto -host '#{ip}' -port '#{port_arg}' -Format xml -o '#{file_path}.xml' > '#{file_path}'"
			`nikto -host '#{ip}' -port '#{port_arg}' -Format xml -o '#{file_path}.xml' > '#{file_path}'`
		end
	end

	def sslscan
		dir_path = "#{@dir_root}/#{__method__}"
		@project.mkdir(dir_path)
		@ips.each do |ip|
			ip = ip[0]
			ports = @targets[[ip]]
			ports.each do |port|
				if port[0] == "tcp"
					file_name = "sslscan-#{ip}_#{port[1]}-#{@time}"
					file_path = "#{dir_path}/#{file_name}"
					p "Execution: sslscan --xml='#{file_path}.xml' #{ip}:#{port[1]} > #{file_path}"
					`sslscan --xml='#{file_path}.xml' #{ip}:#{port[1]} > #{file_path}`
				end
			end
		end
	end
end

attack = AttackEngine.new
attack.banner_gathering
attack.sslscan
#attack.nikto
