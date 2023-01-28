module Telegram
  module Menu
    module MenuActions
      include ActionsBase
      include MenuHelper

      def menu!(*)
        menu text: t('views.menu.root.text'),
             buttons: inline_buttons_from_t(t_path: 'views.menu.root.keyboard')
      end

      def menu_back_to_root!(*)
        menu :edit,
             text: t('views.menu.root.text'),
             buttons: inline_buttons_from_t(t_path: 'views.menu.root.keyboard')
      end

      def menu_router!(action, **params)
        redirect_to "#{action}!", params
      end
    end
  end
end
