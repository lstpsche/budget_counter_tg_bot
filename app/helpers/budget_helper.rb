module BudgetHelper
  include InlineKeyboardHelper

  def set_currency_question(context:)
    question text: t('registration.budget_setup.preferred_currency'),
             context: context
  end

  def set_currency(currency, context:, error_context:)
    if user.budget.update(currency: currency.upcase)
      redirect_to context
    else
      notify_error redirect_to_action: error_context
    end
  end

  def set_monthly_budget_question(context:)
    question text: t('registration.budget_setup.what_monthly_budget', currency: user.budget.currency),
             context: context
  end

  def save_monthly_budget_to_session(budget)
    monthly_budget_to_set = budget.select { |elem| elem.match(/\d+/).present? }.first

    session[:monthly_budget_to_set] = monthly_budget_to_set.to_f
  end

  def save_monthly_budget_to_user
    user.budget.update(monthly_budget: session.delete(:monthly_budget_to_set))
  end

  def set_first_day_of_month_question(context:)
    question text: t('registration.budget_setup.first_day_of_month'),
             context: context
  end

  def set_first_day_of_month(first_day, context:, error_context:)
    if first_day.to_i != 0 && first_day.to_i <= 31 && user.budget.update(first_day_of_month: first_day.to_i)
      redirect_to context
    else
      notify_error redirect_to_action: error_context
    end
  end

  ################# BUTTONS #################

  def change_budget_setup_buttons
    inline_buttons_from_t(t_path: 'registration.budget_setup.change_budget_setup.keyboard')
  end
end
