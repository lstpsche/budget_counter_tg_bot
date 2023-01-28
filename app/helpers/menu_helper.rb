module MenuHelper
  include InlineKeyboardHelper

  # key = :edit if you want to edit menu from callback
  # args = text:, buttons:
  def menu(key = nil, **args)
    if key == :edit
      edit_inline_keyboard router: :menu_router!, **args
    else
      inline_keyboard router: :menu_router!, **args
    end
  end
end
