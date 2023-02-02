module Routers
  module Scopes
    module MenuScope
      # menu views
      include Telegram::Menu::MenuActions
      include Telegram::Menu::Settings::SettingsActions
      include Telegram::Menu::Settings::BudgetSettingsActions
      include Telegram::Menu::Settings::CommonSettingsActions

      # features
      include Telegram::Menu::ExpenseActions
    end
  end
end
