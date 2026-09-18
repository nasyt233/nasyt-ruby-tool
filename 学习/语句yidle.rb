#!/usr/bin/ruby
# -*- coding: UTF-8 -*-


def test
   puts "在 test 方法内"
   yield
   puts "你又回到了 test 方法内"
   yield
end
test {puts "你在块内"}