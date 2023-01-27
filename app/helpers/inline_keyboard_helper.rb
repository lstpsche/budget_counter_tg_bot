module InlineKeyboardHelper
  extend BaseHelper

  def inline_buttons_from_t(t_path:)
    buttons = t(t_path)

    inline_buttons = buttons.keys.inject([]) do |result, button_name|
      result << { text: buttons[button_name], callback_data: button_name }
    end

    [inline_buttons]
  end

  def create_inline_buttons(buttons_data:, context:)
    buttons_data.map do |btn_row|
      btn_row.map do |btn|
        create_inline_button text: btn[:text],
                             context: context,
                             callback_data: btn[:callback_data].to_s
      end
    end
  end

  def create_inline_button(text:, context:, callback_data:)
    { text: text, callback_data: "#{context}:#{callback_data}" }
  end
end
