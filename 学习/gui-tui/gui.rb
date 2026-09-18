#!/usr/bin/ruby
# -*- coding: UTF-8 -*-

Shoes.app do
  para "输入你的名字："
  @name = edit_line
  button "打招呼" do
    alert "你好, #{@name.text}!"
  end
end