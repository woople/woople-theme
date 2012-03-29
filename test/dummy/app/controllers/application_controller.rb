class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :profile_links

  private

  def profile_links
    ProfileLinks.generate
  end
end
