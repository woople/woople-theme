require 'explicit_delegator'

class ProfilePresenter < ExplicitDelegator
  DEFAULT_IMAGE        = 'woople-theme/missing-profile.png'
  MISSING_WOOPLE_IMAGE = '/assets/retina_thumb/missing.png'

  enforce_definitions :image, :sections

  def image
    normalized(profile.image)
  end

  def sections
    @sections ||= ThemePresentation.wrap_collection(profile.sections, ProfileSectionPresenter)
  end

  private

  def profile
    __getobj__
  end

  def normalized(image)
    if image.nil? || image == MISSING_WOOPLE_IMAGE
      DEFAULT_IMAGE
    else
      image
    end
  end
end
