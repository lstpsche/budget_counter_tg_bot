module Telegram
  module SignUp
    module CreateUserActions
      include ActionsBase
      include RegistrationHelper

      def setup_user!(*)
        if create_new_user(from)
          notify text: t('registration.user_setup.user_created'),
                 redirect_to_action: :start_budget_setup!
        else
          notify text: t('registration.user_setup.could_not_create_user'),
                 redirect_to_action: :restart_confirmation!
        end
      end

      def restart_confirmation!(*)
        confirm_info_reply text: t('registration.user_setup.confirm_setup_restart'),
                           context: :restart!
      end

      def restart!(answer)
        if parse_reply_keyboard_response(answer)
          notify text: t('registration.user_setup.restart'),
                 redirect_to_action: :setup_user!
        else
          notify text: t('registration.user_setup.goodbye')
        end
      end
    end
  end
end
