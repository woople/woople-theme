require 'delegate'

module WoopleTheme
  module Dashboard
    class OrganizationAccountsPresenter < SimpleDelegator
      def accounts
        __getobj__
      end
    end
  end
end
