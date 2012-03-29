class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :profile_model, :menu_model

  private

  def profile_model
    ProfileLinks.generate
  end

  def menu_model
    Menu.generate(@selection)
  end
end
