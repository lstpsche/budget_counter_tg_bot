module Telegram
  module Menu
    module Settings
      module CommonSettingsActions
        include MenuHelper

        def common_settings!(*)
          menu :edit, view: :common_settings
        end

        def settings_amount_stylization!(*)
          # TODO: fill logic
          # TODO: logic - toggle on tap
          # TODO: figure out how to show "Turn ON ..."/"Turn OFF ..." text dynamically (depending on value from base)
        end
      end
    end
  end
end
