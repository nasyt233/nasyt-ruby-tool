require 'tty-prompt'

prompt = TTY::Prompt.new

# 交互式菜单
choice = prompt.select("🏠 你想做什么？") do |menu|
  menu.choice "📝 查看任务", "查看任务"
  menu.choice "➕ 添加任务", 2
  menu.choice "❌ 删除任务", 3
  menu.choice "🚪 退出", 4
end

puts "你选择了选项 #{choice}"