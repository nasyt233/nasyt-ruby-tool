#!/usr/bin/ruby
 
BEGIN { 
  # BEGIN 代码块
  puts "BEGIN 代码块"
} 
 
END { 
  # END 代码块
  puts "END 代码块"
}
  # MAIN 代码块
puts "MAIN 代码块"

block_name{
   statement1
   statement2
   ..........
}