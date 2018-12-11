#! /usr/bin/env ruby
# Author: Xan

require 'nokogiri'

class Parser
	def initialize()
		@result_hash = {}
		@dir_root = "data"
	end

	def port_scan()
		file_path = "#{@dir_root}/port_detection/"
		files = Dir.entries(file_path)
		files.delete(".")
		files.delete("..")
		files.each do |file|
			target_array = []
			states_array = []
			port_array = []
	
			absolute_path = file_path + file
			doc = File.open(absolute_path) { |f| Nokogiri::XML(f) }
	
			ip_address = doc.xpath("//address//@addr")
			hostname = doc.xpath("//hostnames//hostname[@type=\"user\"]//@name")
			states = doc.xpath("//state//@state")
			protocols = doc.xpath("//port//@protocol")
			portids = doc.xpath("//port//@portid")
	
			if hostname.empty?
				ip_address.each do |ip|
					target_array << ip.to_s
				end
			else
				hostname.each do |ip|
					target_array << ip.to_s
				end
			end
	
			states.each do |state|
				states_array << state.to_s
			end
	
			keep_index = states_array.each_index.select{ |i| states_array[i] == "open" }
			keep_index.each do |keep|
				port_array << [protocols[keep].to_s, portids[keep].to_s]
			end
			
			@result_hash.store(target_array, port_array)
		end
	
		@result_hash.delete_if { |key, value| value.to_s.strip == '[]' }
		return @result_hash
	end

	def report
		file_path = "#{@dir_root}/*/"
		files = Dir.glob("#{file_path}*.xml")
		port_scan.keys.each do |target|
			target = target.join
			target_file = files.grep /#{target}/
			target_file.each do |file|
			end
		end
		#files.each do |file|
		#end
	end
end

parser = Parser.new
#p parser.port_scan
p parser.report
