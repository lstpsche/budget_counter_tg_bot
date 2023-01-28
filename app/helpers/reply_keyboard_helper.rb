module ReplyKeyboardHelper
  extend BaseHelper

  def reply_keyboard(text:, buttons:)
    respond_with :message, text: text, reply_markup: {
      keyboard: buttons,
      resize_keyboard: true,
      one_time_keyboard: true
    }
  end
end
