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
    include Scopes::MainMenuScope

    def start!(*)
      return redirect_to :main_menu! if user.present?

      notify text: t('registration.new_user_greeting'),
             redirect_to_action: :setup_user!
    end

    def help!(*)
      notify text: t('help')
    end

    def callback_query(callback)
      redirect_to *callback.split(':')
    end

    def message(*)
      redirect_to :help!
    end
  end
end
