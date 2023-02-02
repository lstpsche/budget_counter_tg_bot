module RegistrationHelper
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
end
