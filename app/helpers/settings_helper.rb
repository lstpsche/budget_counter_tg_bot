module SettingsHelper
  def amount_stylization_button
    translation_path = 'features.amount_stylization_settings'
    value = t(!user.amount_stylization, scope: translation_path)

    {
      text: t(:button_text, scope: translation_path, value: value),
      action: 'set_amount_stylization'
    }
  end
end
