module InlineKeyboardHelper
  extend BaseHelper

  def inline_keyboard(...)
    respond_with :message, **inline_keyboard_params(...)
  end

  def edit_inline_keyboard(**args)
    type = args[:text].present? ? 'text' : 'reply_markup'

    edit_message(type, **inline_keyboard_params(**args))
  end

  def inline_keyboard_params(text:, buttons:, router:)
    {
      text: text,
      reply_markup: {
        inline_keyboard: create_inline_buttons(buttons_data: buttons, router: router)
      }
    }
  end

  ################### BUTTONS ###################

  def create_inline_buttons(buttons_data:, router:)
    buttons_data.map do |btn_row|
      btn_row.map do |btn_data|
        create_inline_button router: router, **btn_data
      end
    end
  end

  def create_inline_button(text:, router:, action:, params: {})
    # FORMAT: router::action?data_1=val_1&data_2=val_2
    callback_data = "#{router}::#{action}"
    callback_data = [callback_data, params.to_query].join('?') if params.present?

    { text: text, callback_data: callback_data }
  end

  def inline_buttons_from_t(t_path:)
    buttons = t(t_path)

    buttons.keys.inject([]) do |kboard_result, row_data_key|
      row_data = buttons[row_data_key]

      row = row_data.keys.inject([]) do |row_result, button_name|
        row_result << { text: row_data[button_name].to_s, action: button_name.to_s }
      end

      kboard_result << row
    end
  end
end
