module MessageHelper
  extend BaseHelper
  include InlineKeyboardHelper

  ############## GENERAL ##############
  def send_text(text)
    respond_with :message, text: text, parse_mode: 'HTML'
  end

  def reply_keyboard(text:, buttons:)
    respond_with :message, text: text, reply_markup: {
      keyboard: buttons,
      resize_keyboard: true,
      one_time_keyboard: true
    }
  end

  def inline_keyboard(text:, buttons:, context:)
    respond_with :message, text: text, reply_markup: {
      inline_keyboard: create_inline_buttons(buttons_data: buttons, context: context)
    }
  end

  ############## SPECIFIC ##############
  DEFAULT_CONFIRM_BUTTONS_INLINE = [
    [
      { text: t('defaults.confirmation_dialog.yes_button'), callback_data: 'true' },
      { text: t('defaults.confirmation_dialog.no_button'), callback_data: 'false' },
    ]
  ].freeze

  DEFAULT_CONFIRM_BUTTONS_REPLY = [
    [t('defaults.confirmation_dialog.yes_button'), t('defaults.confirmation_dialog.no_button')]
  ].freeze

  DEFAULT_CONFIRM_REPLY_MATCHER = {
    t('defaults.confirmation_dialog.yes_button') => true,
    t('defaults.confirmation_dialog.no_button') => false
  }.freeze

  def notify(text:, redirect_to_action: nil)
    send_text text

    redirect_to redirect_to_action if redirect_to_action.present?
  end

  # !!! needs MessageContext included where method is called, if context passed !!!
  def question(text:, context: nil)
    save_context context if context.present?

    send_text text
  end

  # !!! needs MessageContext included where method is called, if context passed !!!
  def confirm_info_reply(text: t('defaults.confirmation_dialog.text'),
                         buttons: DEFAULT_CONFIRM_BUTTONS_REPLY,
                         context: nil)
    save_context context if context.present?

    reply_keyboard(text: text, buttons: buttons)
  end

  def confirm_info_inline(text: t('defaults.confirmation_dialog.text'),
                          context:)
    inline_keyboard text: text, buttons: DEFAULT_CONFIRM_BUTTONS_INLINE, context: context
  end

  def parse_reply_keyboard_response(response, matcher: DEFAULT_CONFIRM_REPLY_MATCHER)
    matcher[response]
  end
end
