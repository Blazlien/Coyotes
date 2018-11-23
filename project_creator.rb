#! /usr/bin/env ruby
# Authro: Xan

require 'fileutils'

class ProjectCreator
	def initialize()
	end

	def mkdir(action)
		FileUtils.mkdir_p(action) 
	end
end

#FileUtils.mkdir_p 'dir_name'
#directory_name = "name/test"
#Dir.mkdir(directory_name) unless File.exists?(directory_name)
