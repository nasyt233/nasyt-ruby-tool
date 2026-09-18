# menu_app.rb
require 'glimmer-dsl-libui'

include Glimmer

# 数据
@selected_option = "未选择"
@counter = 0
@items = ["选项 A", "选项 B", "选项 C", "选项 D"]
@selected_index = 0
@combo = nil  # 存储 combobox 引用

# 主窗口
window("📋 菜单选择界面", 500, 300) {
  vertical_box {
    # ===== 标题 =====
    label("🎯 请从以下选项中选择")
    
    # ===== 分隔线 =====
    horizontal_separator
    
    # ===== 方式1: 按钮菜单 =====
    group("方式1: 按钮选择") {
      horizontal_box {
        @items.each do |item|
          button(item) {
            on_clicked {
              @selected_option = item
              @selected_index = @items.index(item)
              @result_label.text = "✅ 已选择: #{item}"
              @counter += 1
              @count_label.text = @counter.to_s
              @index_label.text = @selected_index.to_s
            }
          }
        end
      }
    }
    
    # ===== 方式2: 下拉选择 =====
    group("方式2: 下拉菜单") {
      horizontal_box {
        label("选择: ")
        
        @combo = combobox {
          items @items
          
          on_selected {
            # 使用 @combo.selected 获取选中索引
            idx = @combo.selected
            if idx && idx >= 0 && idx < @items.length
              @selected_option = @items[idx]
              @selected_index = idx
              @result_label.text = "✅ 已选择: #{@selected_option}"
              @index_label.text = @selected_index.to_s
              @counter += 1
              @count_label.text = @counter.to_s
            end
          }
        }
      }
    }
    
    # ===== 分隔线 =====
    horizontal_separator
    
    # ===== 结果显示 =====
    group("📊 选择结果") {
      horizontal_box {
        label("当前选择: ")
        @result_label = label("未选择")
      }
      
      horizontal_box {
        label("索引: ")
        @index_label = label("无")
      }
      
      horizontal_box {
        label("总选择次数: ")
        @count_label = label("0")
      }
    }
    
    # ===== 底部按钮 =====
    horizontal_box {
      button("🔁 重置") {
        on_clicked {
          @selected_option = "未选择"
          @counter = 0
          @selected_index = 0
          @result_label.text = "🔄 已重置"
          @index_label.text = "无"
          @count_label.text = "0"
        }
      }
      
      button("📋 查看选择历史") {
        on_clicked {
          msg_box("选择历史", "当前选择: #{@selected_option}\n索引: #{@selected_index}\n总次数: #{@counter}")
        }
      }
      
      button("🚪 退出") {
        on_clicked {
          exit
        }
      }
    }
  }
}.show