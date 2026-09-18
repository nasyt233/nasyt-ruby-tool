# termux环境
# apt install tcl tk xorgproto libx11 libxft

# x86-64环境
# apt install -y tcl tk tcl-dev tk-dev libx11-dev

require 'tk'

# 创建主窗口
root = TkRoot.new { title "Hello Tk" }

# 创建一个标签并显示
TkLabel.new(root) do
  text '欢迎来到 Tk 的世界！'
  pack { padx 15; pady 15 }
end

# 启动事件循环
Tk.mainloop