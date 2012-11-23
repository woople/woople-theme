require 'explicit_delegator'

class MenuWidgetPresenter < ExplicitDelegator
  enforce_definitions :partial_path, :model
end
