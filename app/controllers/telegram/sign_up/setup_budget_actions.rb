module Telegram
  module SignUp
    module SetupBudgetActions
      include ActionsBase
      include RegistrationHelper

      def start_budget_setup!(*)
        notify text: t('registration.budget_setup.start_setup'),
               redirect_to_action: :currency_setup!
      end

      def currency_setup!(*)
        question text: t('registration.budget_setup.preferred_currency'),
                 context: :set_currency!
      end

      def set_currency!(currency)
        if user.update(currency: currency.upcase)
          redirect_to :monthly_budget_setup!
        else
          notify text: t('registration.budget_setup.errors.could_not_set_currency'),
                 redirect_to_action: :currency_setup!
        end
      end

      def monthly_budget_setup!(*)
        question text: t('registration.budget_setup.what_monthly_budget', currency: user.currency),
                 context: :set_monthly_budget!
      end

      def set_monthly_budget!(*budget)
        save_monthly_budget_to_session(budget)

        redirect_to :monthly_budget_confirmation!
      end

      def monthly_budget_confirmation!(*)
        confirm_info_inline text: t('registration.budget_setup.confirm_monthly_budget',
                                   budget: session[:monthly_budget_to_set], currency: user.currency),
                            router: :confirm_monthly_budget!
      end

      def confirm_monthly_budget!(answer)
        if answer == 'true'
          save_monthly_budget_to_user

          notify text: t('registration.registration_completed'),
                 redirect_to_action: :menu!
        else
          redirect_to :change_budget_setup!
        end
      end

      def change_budget_setup!
        inline_keyboard text: t('views.change_budget_setup.text'),
                        buttons: inline_buttons_from_t(t_path: 'views.change_budget_setup.keyboard'),
                        router: :change_budget_setup_answer!
      end

      def change_budget_setup_answer!(answer)
        redirect_to "#{answer}_setup!"
      end
    end
  end
end
