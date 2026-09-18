# 文件名: hello_tui.rb
# 运行方式: ruby hello_tui.rb

require "ratatui_ruby"

# run 方法会接管终端，并在退出时恢复原状
RatatuiRuby.run do |tui|
  loop do
    # draw 块负责每一帧的渲染
    tui.draw do |frame|
      # 创建一个带标题和边框的段落，并居中显示
      paragraph = tui.paragraph(
        text: "Hello, RatatuiRuby!\n按 q 退出",
        alignment: :center,
        block: tui.block(
          title: " 我的第一个 TUI ",
          borders: [:all],
          border_style: { fg: "cyan" }
        )
      )
      # 将段落渲染到整个屏幕区域 (frame.area)
      frame.render_widget(paragraph, frame.area)
    end

    # poll_event 会阻塞等待并返回下一个输入事件
    event = tui.poll_event

    # 使用模式匹配来处理事件，当按下 'q' 键或 Ctrl+C 时退出循环
    case event
    in { type: :key, code: "q" } | { type: :key, code: "c", modifiers: [:ctrl] }
      break
    else
      # 忽略其他所有事件
    end
  end
end