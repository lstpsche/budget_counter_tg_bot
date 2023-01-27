module Telegram
  module MainMenu
    module MainMenuActions
      include ActionsBase
      include MainMenuHelper

      def main_menu!(*)
        inline_keyboard text: t('main_menu.root'),
                        buttons: main_menu_root_buttons,
                        context: :main_menu_router!
      end

      def main_menu_router!(action)
        redirect_to "#{action}!"
      end
    end
  end
end
