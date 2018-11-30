#! /usr/bin/env ruby
# Author: Xan

require 'nokogiri'

def parser()
	file_path = "data/port_detection/"
	files = Dir.entries(file_path)
	files.delete(".")
	files.delete("..")

	result_hash = {}

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
		
		result_hash.store(target_array, port_array)
	end

	result_hash.delete_if { |key, value| value.to_s.strip == '[]' }
	return result_hash
end

parser()
