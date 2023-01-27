module BaseHelper
  def t(path, **args)
    I18n.t(path, **args)
  end

  def redirect_to(action, *args)
    # previous solution was not saving session due to controller inside controller inside controller inside... structure
    # left here for memory and in case if it would be needed
    # controller = Routers::BotRouter.new(bot, update)
    # controller.process(action, **args)
    self.process(action, *args)
  end
end
