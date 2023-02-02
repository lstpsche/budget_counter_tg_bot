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
        if user.budget.update(currency: currency.upcase)
          redirect_to :monthly_budget_setup!
        else
          notify_error redirect_to_action: :currency_setup!
        end
      end

      def monthly_budget_setup!(*)
        question text: t('registration.budget_setup.what_monthly_budget', currency: user.budget.currency),
                 context: :set_monthly_budget!
      end

      def set_monthly_budget!(*budget)
        save_monthly_budget_to_session(budget)

        redirect_to :monthly_budget_confirmation!
      end

      def monthly_budget_confirmation!(*)
        confirm_info_inline text: t('registration.budget_setup.confirm_monthly_budget',
                                   budget: session[:monthly_budget_to_set], currency: user.budget.currency),
                            router: :confirm_monthly_budget!
      end

      def confirm_monthly_budget!(answer)
        if answer == 'true'
          save_monthly_budget_to_user

          redirect_to :first_day_of_month_setup!
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

      def first_day_of_month_setup!(*)
        question text: t('registration.budget_setup.first_day_of_month'),
                 context: :set_first_day_of_month!
      end

      def set_first_day_of_month!(*args)
        first_day = args.first

        if first_day.to_i != 0 && first_day.to_i <= 31 && user.budget.update(first_day_of_month: first_day.to_i)
          notify text: t('registration.registration_completed'),
                 redirect_to_action: :menu!
        else
          notify_error redirect_to_action: :first_day_of_month_setup!
        end
      end
    end
  end
end
