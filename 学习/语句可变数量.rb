#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
 
def abc (*args)
  len = args.length
  puts "共有#{len}个参数"
  for i in 0...len
    puts "第#{i}个参数为:#{args[i]}"
  end
end

abc "aaa", "bbb", "ccc", "ddd"