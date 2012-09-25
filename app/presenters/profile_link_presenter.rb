require 'explicit_delegator'

class ProfileLinkPresenter < ExplicitDelegator
  enforce_definitions :name, :url
end
