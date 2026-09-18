#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
 
def test
   yield 5
   puts "在 test 方法内"
   yield 100
end

test {|i| puts "你在块 #{i} 内"}