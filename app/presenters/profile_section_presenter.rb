require 'delegate'

class ProfileSectionPresenter < SimpleDelegator

  def links
    ThemePresentation.wrap_collection(section, ProfileLinkPresenter)
  end

  private

  def section
    __getobj__
  end
end
