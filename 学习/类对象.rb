#!/usr/bin/ruby
 
class Sample
   def hello
      a = 123
      print "Hello Ruby!" , a
   end
end
 
# 使用上面的类来创建对象
object = Sample. new
object.hello