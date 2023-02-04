module Telegram
  module Menu
    module MenuActions
      include MenuHelper

      def menu!(*)
        menu
      end

      def menu_back_to_root!(*)
        menu :edit
      end

      def menu_router!(action, **params)
        redirect_to "#{action}!", params
      end
    end
  end
end
