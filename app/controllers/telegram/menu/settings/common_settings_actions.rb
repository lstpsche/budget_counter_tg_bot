module Telegram
  module Menu
    module Settings
      module CommonSettingsActions
        include ActionsBase
        include MenuHelper
        include SettingsHelper

        def common_settings!(*)
          menu :edit, view: :common_settings
        end

        def settings_amount_stylization!(*)
          menu :edit, view: :common_settings,
                      buttons: [
                                 [amount_stylization_button],
                                 *inline_buttons_from_t(t_path: 'views.menu.settings_amount_stylization.keyboard')
                               ]
        end

        def set_amount_stylization!(*)
          user.toggle_amount_stylization

          answer_callback_query t(user.amount_stylization, scope: 'features.amount_stylization_settings.callback_alert')

          redirect_to :settings_amount_stylization!
        end
      end
    end
  end
end
