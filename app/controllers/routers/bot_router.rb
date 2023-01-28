module Routers
  class BotRouter < Telegram::Bot::UpdatesController
    include Telegram::Bot::UpdatesController::MessageContext

    include BaseHelper
    include MessageHelper

    ############ routing scopes #############
    ############ ! IMPORTANT ! ##############
    ## ALL actions should have UNIQUE NAME ##
    #########################################
    include Scopes::SignUpScope
    include Scopes::MenuScope

    def start!(*)
      return redirect_to :menu! if user.present?

      notify text: t('registration.new_user_greeting'),
             redirect_to_action: :setup_user!
    end

    def help!(*)
      notify text: t('help')
    end

    def callback_query(callback)
      router, action_params = callback.split('::')
      action, params_string = action_params&.split('?')
      params = Rack::Utils.parse_nested_query(params_string)&.with_indifferent_access

      if params.present?
        return redirect_to router, action, params
      end

      redirect_to router, action
    end

    def message(*)
      redirect_to :help!
    end
  end
end
