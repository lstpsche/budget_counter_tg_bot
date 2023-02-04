module Telegram
  module Menu
    module Settings
      module SettingsActions
        include MenuHelper

        def settings!(*)
          menu :edit, view: :settings
        end
      end
    end
  end
end
