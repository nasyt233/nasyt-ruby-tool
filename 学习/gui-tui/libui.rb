require 'glimmer-dsl-libui'

include Glimmer

window('我的第一个 LibUI 应用', 300, 200) {
  vertical_box {
    label('欢迎使用 Glimmer DSL for LibUI！')

    button('点我') {
      on_clicked do
        msg_box('提示', '按钮被点击了！')
      end
    }
  }
}.show