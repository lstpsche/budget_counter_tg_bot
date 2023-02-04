module MenuHelper
  include InlineKeyboardHelper

  # key = :edit if you want to edit menu from callback
  # args = text:, buttons:
  def menu(key = nil, text: nil, buttons: nil, view: :root)
    path = "views.menu.#{view}"
    text ||= t(:text, scope: path)
    buttons ||= inline_buttons_from_t(t_path: "#{path}.keyboard")

    if key == :edit
      edit_inline_keyboard router: :menu_router!, text: text, buttons: buttons
    else
      inline_keyboard router: :menu_router!, text: text, buttons: buttons
    end
  end

  def back_button(action)
    {
      text: t('menu.back_button'),
      action: action
    }
  end
end
