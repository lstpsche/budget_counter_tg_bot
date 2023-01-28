module Routers
  module Scopes
    module MenuScope
      include Telegram::Menu::MenuActions
      include Telegram::Menu::ExpenseActions
    end
  end
end
