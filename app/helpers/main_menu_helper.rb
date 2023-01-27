module MainMenuHelper
  include InlineKeyboardHelper

  def main_menu_root_buttons
    # TODO: replace with actual buttons via ```inline_buttons_from_t(t_path: ...)``` method
    [
      [
        { text: 'Button 1', callback_data: 'button_1' }
      ],

      [
        { text: 'Button 2.1', callback_data: 'button_2_1' },
        { text: 'Button 2.2', callback_data: 'button_2_2' }
      ]
    ]
  end
end
