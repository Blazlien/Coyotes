#! /usr/bin/env ruby
# Author: Xan

require './lib/info_gather_engine'
require './lib/attack'

nmap = PortScanEngine.new(ARGV)
nmap.port_detection

attack = AttackEngine.new
attack.wafw00f
attack.lbd
attack.banner_gathering
attack.sslscan
attack.nikto
