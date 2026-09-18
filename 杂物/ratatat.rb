require "ratatat"

class MyApp < Ratatat::App
  def compose
    [
      Ratatat::Vertical.new.tap do |v|
        v.mount(
          Ratatat::Static.new("Hello, World!"),
          Ratatat::Button.new("Click me", id: "btn")
        )
      end
    ]
  end

  def on_button_pressed(message)
    query_one("#btn").label = "Clicked!"
  end
end

MyApp.new.run