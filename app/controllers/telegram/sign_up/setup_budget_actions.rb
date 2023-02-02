module Telegram
  module SignUp
    module SetupBudgetActions
      include ActionsBase
      include RegistrationHelper
      include BudgetHelper

      def start_budget_setup!(*)
        notify text: t('registration.budget_setup.start_setup'),
               redirect_to_action: :currency_setup!
      end

      def currency_setup!(*)
        set_currency_question context: :set_currency!
      end

      def set_currency!(currency)
        set_currency currency,
                     context: :monthly_budget_setup!,
                     error_context: :currency_setup!
      end

      def monthly_budget_setup!(*)
        set_monthly_budget_question context: :set_monthly_budget!
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
        set_first_day_of_month_question context: :set_first_day_of_month!
      end

      def set_first_day_of_month!(*args)
        first_day = args.first

        set_first_day_of_month first_day,
                               context: :finish_budget_setup!,
                               error_context: :first_day_of_month_setup!
      end

      def finish_budget_setup!(*)
        notify text: t('registration.registration_completed'),
               redirect_to_action: :menu!
      end
    end
  end
end
