module Telegram
  module Menu
    module Settings
      module BudgetSettingsActions
        include MenuHelper
        include BudgetHelper

        def show_budget_settings!(*)
          menu view: :budget_settings
        end

        def budget_settings!(*)
          menu :edit, view: :budget_settings
        end

        def settings_currency!(*)
          set_currency_question context: :settings_set_currency!
        end

        def settings_set_currency!(currency)
          set_currency currency,
                       context: :settings_set_currency_success!,
                       error_context: :show_budget_settings!
        end

        def settings_set_currency_success!(*)
          notify text: t('settings.budget_settings.currency_set'),
                 redirect_to_action: :show_budget_settings!
        end

        def settings_monthly_budget!(*)
          set_monthly_budget_question context: :settings_set_monthly_budget!
        end

        def settings_set_monthly_budget!(*budget)
          save_monthly_budget_to_session(budget)
          save_monthly_budget_to_user

          notify text: t('settings.budget_settings.monthly_budget_set'),
                 redirect_to_action: :show_budget_settings!
        end

        def settings_first_day_of_month!(*)
          set_first_day_of_month_question context: :settings_set_first_day_of_month!
        end

        def settings_set_first_day_of_month!(*args)
          first_day = args.first

          set_first_day_of_month first_day,
                                 context: :settings_set_first_day_of_month_success!,
                                 error_context: :show_budget_settings!
        end

        def settings_set_first_day_of_month_success!(*)
          notify text: t('settings.budget_settings.first_day_set'),
                 redirect_to_action: :show_budget_settings!
        end
      end
    end
  end
end
