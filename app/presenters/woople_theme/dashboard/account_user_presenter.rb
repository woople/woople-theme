require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class AccountUserPresenter < ExplicitDelegator
      enforce_definitions :image, :name, :member_dashboard_path, :status_color, :status_description

      def image
        __getobj__.image == '/assets/retina_thumb/missing.png' ? 'woople-theme/missing-profile.png' : __getobj__.image
      end
    end
  end
end
