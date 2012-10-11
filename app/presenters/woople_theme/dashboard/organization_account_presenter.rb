require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class OrganizationAccountPresenter < ExplicitDelegator
      enforce_definitions :name, :users
    end
  end
end
