module Routers
  module Scopes
    module MenuScope
      # Menu views
      include Telegram::Menu::MenuActions

      # Settings
      include Telegram::Menu::Settings::SettingsActions
      include Telegram::Menu::Settings::BudgetSettingsActions
      include Telegram::Menu::Settings::CommonSettingsActions

      # Features
      include Telegram::Menu::ExpenseActions
    end
  end
end
