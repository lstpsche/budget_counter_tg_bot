module RegistrationHelper
  include InlineKeyboardHelper

  def create_new_user(from)
    new_user = User.new(
      id: from['id'],
      first_name: from['first_name'],
      last_name: from['last_name'],
      username: from['username'],
      language_code: from['language_code']
    )

    new_user.save
  end

  def save_monthly_budget_to_session(budget)
    monthly_budget_to_set = budget.select { |elem| elem.match(/\d+/).present? }.first

    session[:monthly_budget_to_set] = monthly_budget_to_set.to_f
  end

  def save_monthly_budget_to_user
    user.budget.update(monthly_budget: session.delete(:monthly_budget_to_set))
  end

  ################# BUTTONS #################

  def change_budget_setup_buttons
    inline_buttons_from_t(t_path: 'registration.budget_setup.change_budget_setup.keyboard')
  end
end
