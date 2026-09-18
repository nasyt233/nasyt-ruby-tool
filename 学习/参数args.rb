#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
=begin
(0..10).each do |i|
    puts "#{ARGV[0]}#{i}"
end
=end

a = 123
s = ARGV[1]
puts s
for i in 0..5 do
  print a,"#{ARGV[0]}",i,"\n"
end

