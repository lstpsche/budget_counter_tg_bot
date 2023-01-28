module MessageHelper
  extend BaseHelper
  include InlineKeyboardHelper
  include ReplyKeyboardHelper

  ############## GENERAL ##############
  def send_text(text)
    respond_with :message, text: text, parse_mode: 'HTML'
  end

  def notify(text:, redirect_to_action: nil)
    send_text text

    redirect_to redirect_to_action if redirect_to_action.present?
  end

  # !!! needs MessageContext included where method is called, if context passed !!!
  def question(text:, context: nil)
    save_context context if context.present?

    send_text text
  end

  ############## SPECIFIC ##############

  DEFAULT_CONFIRM_BUTTONS_REPLY = [[
    t('views.default_confirmation.keyboard.row_1.true'),
    t('views.default_confirmation.keyboard.row_1.false')
  ]].freeze

  DEFAULT_CONFIRM_REPLY_MATCHER = {
    t('views.default_confirmation.keyboard.row_1.true') => true,
    t('views.default_confirmation.keyboard.row_1.false') => false
  }.freeze

  # !!! needs MessageContext included where method is called, if context passed !!!
  def confirm_info_reply(text: t('views.default_confirmation.text'),
                         buttons: DEFAULT_CONFIRM_BUTTONS_REPLY,
                         context: nil)
    save_context context if context.present?

    reply_keyboard text: text, buttons: buttons
  end

  def confirm_info_inline(text: t('views.default_confirmation.text'),
                          router:)
    inline_keyboard text: text,
                    buttons: inline_buttons_from_t(t_path: 'views.default_confirmation.keyboard'),
                    router: router
  end

  def parse_reply_keyboard_response(response, matcher: DEFAULT_CONFIRM_REPLY_MATCHER)
    matcher[response]
  end
end
