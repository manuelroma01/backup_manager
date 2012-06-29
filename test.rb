#!/usr/bin/env ruby
require 'rubygems'
require 'net/ssh'

HOST = '172.20.32.25'
USER = 'antaviana'
PASS = 'H1antaj0'

Net::SSH.start(HOST, USER, :password => PASS) do |ssh|
	output = ssh.exec!('uname -a')
  puts output
end