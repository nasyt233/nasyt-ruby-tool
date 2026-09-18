# menu_app.rb
require 'glimmer-dsl-libui'

include Glimmer

# ===== 数据 =====
@items = [
  { name: "📝 记事本", desc: "简单文本编辑器" },
  { name: "📊 计数器", desc: "数字计数器" },
  { name: "🎨 颜色选择", desc: "选择颜色" },
  { name: "📋 待办列表", desc: "简单待办管理" },
  { name: "ℹ️ 关于", desc: "显示程序信息" }
]
@selected_index = 0

# ===== 功能页面 =====

# 1. 记事本
def show_notepad
  @text_content = ""
  
  window("📝 记事本", 400, 300) {
    vertical_box {
      label("简单记事本")
      
      # 使用 entry 替代 multiline_entry
      @input = entry {
        stretchy true
      }
      
      horizontal_box {
        button("保存") {
          on_clicked {
            @text_content = @input.text
            msg_box("保存", "已保存内容:\n#{@text_content}")
          }
        }
        
        button("清空") {
          on_clicked {
            @input.text = ""
            @text_content = ""
          }
        }
        
        button("返回") {
          on_clicked { destroy }
        }
      }
    }
  }.show
end

# 2. 计数器
def show_counter
  @count = 0
  
  window("📊 计数器", 300, 200) {
    vertical_box {
      label("计数器")
      
      @count_label = label("0")
      
      horizontal_box {
        button("-") {
          on_clicked {
            @count -= 1
            @count_label.text = @count.to_s
          }
        }
        
        button("重置") {
          on_clicked {
            @count = 0
            @count_label.text = "0"
          }
        }
        
        button("+") {
          on_clicked {
            @count += 1
            @count_label.text = @count.to_s
          }
        }
      }
      
      button("返回") {
        on_clicked { destroy }
      }
    }
  }.show
end

# 3. 颜色选择
def show_color_picker
  @colors = ["红色", "绿色", "蓝色", "黄色", "紫色"]
  @selected_color = 0
  
  window("🎨 颜色选择", 350, 250) {
    vertical_box {
      label("选择颜色")
      
      horizontal_box {
        @colors.each do |color|
          button(color) {
            on_clicked {
              @selected_color = @colors.index(color)
              @result_label.text = "✅ 已选择: #{color}"
            }
          }
        end
      }
      
      @result_label = label("未选择")
      
      button("返回") {
        on_clicked { destroy }
      }
    }
  }.show
end

# 4. 待办列表（使用 combobox 替代 listbox）
def show_todo
  @todos = ["学习 Ruby", "完成项目", "提交代码"]
  
  window("📋 待办列表", 400, 350) {
    vertical_box {
      label("待办事项")
      
      # 使用 combobox 显示待办列表
      @todo_combo = combobox {
        items @todos
        stretchy true
      }
      
      horizontal_box {
        @input = entry {
          stretchy true
        }
        
        button("添加") {
          on_clicked {
            if @input.text.strip != ""
              @todos << @input.text
              @todo_combo.items = @todos
              @input.text = ""
            end
          }
        }
      }
      
      horizontal_box {
        button("删除选中") {
          on_clicked {
            idx = @todo_combo.selected
            if idx && idx >= 0 && idx < @todos.length
              @todos.delete_at(idx)
              @todo_combo.items = @todos
            end
          }
        }
        
        button("清空所有") {
          on_clicked {
            @todos = []
            @todo_combo.items = @todos
          }
        }
        
        button("返回") {
          on_clicked { destroy }
        }
      }
    }
  }.show
end

# 5. 关于
def show_about
  window("ℹ️ 关于", 400, 250) {
    vertical_box {
      label("📋 菜单演示程序")
      label("版本: 1.0")
      label("框架: Glimmer DSL for LibUI")
      label("功能: 展示类似 dialog 的菜单界面")
      label("")
      label("每个选项对应一个独立功能页面")
      
      button("关闭") {
        on_clicked { destroy }
      }
    }
  }.show
end

# ===== 主菜单 =====
window("📋 主菜单 - 类似 dialog 风格", 500, 400) {
  vertical_box {
    # ===== 标题 =====
    label("🎯 请选择功能")
    label("按上下键选择，回车确认")
    
    # ===== 菜单列表 =====
    group("功能列表") {
      stretchy true
      
      vertical_box {
        @items.each_with_index do |item, idx|
          horizontal_box {
            stretchy false
            
            # 选中指示器
            label(idx == @selected_index ? "▶" : " ") {
              stretchy false
            }
            
            # 选项名称
            label(item[:name]) {
              stretchy false
            }
            
            # 选项描述
            label(item[:desc]) {
              stretchy true
            }
          }
        end
      }
    }
    
    # ===== 底部操作按钮 =====
    horizontal_box {
      stretchy false
      
      button("✅ 确认选择") {
        on_clicked {
          case @selected_index
          when 0 then show_notepad
          when 1 then show_counter
          when 2 then show_color_picker
          when 3 then show_todo
          when 4 then show_about
          end
        }
      }
      
      button("⬆ 上移") {
        on_clicked {
          if @selected_index > 0
            @selected_index -= 1
            # 刷新界面 - 重新创建窗口
            # 简单起见，用 msg_box 提示
            msg_box("提示", "已上移到: #{@items[@selected_index][:name]}")
          end
        }
      }
      
      button("⬇ 下移") {
        on_clicked {
          if @selected_index < @items.length - 1
            @selected_index += 1
            msg_box("提示", "已下移到: #{@items[@selected_index][:name]}")
          end
        }
      }
      
      button("🚪 退出") {
        on_clicked { exit }
      }
    }
  }
}.show