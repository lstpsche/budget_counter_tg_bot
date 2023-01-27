module Routers
  module Scopes
    module SignUpScope
      include Telegram::SignUp::CreateUserActions
      include Telegram::SignUp::SetupBudgetActions
    end
  end
end
