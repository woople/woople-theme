class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :profile_model, :menu_model, :impersonation_banner_helper

  private

  def profile_model
    ProfileLinks.generate
  end

  def menu_model
    Menu.generate(@selection)
  end

  def impersonation_banner_helper
    {
      logged_in_as: nil,
      impersonating: nil,
      impersonating?: false
    }
  end
end
