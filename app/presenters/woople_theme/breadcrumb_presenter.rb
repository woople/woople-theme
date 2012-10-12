require 'explicit_delegator'

module WoopleTheme
  class BreadcrumbPresenter < ExplicitDelegator
    enforce_definitions :organization_path
  end
end
