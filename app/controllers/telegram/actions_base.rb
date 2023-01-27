module Telegram
  module ActionsBase
    private

    def user
      @user ||= User.find_by(id: from['id'])
    end
  end
end
