require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class AccountUserPresenter < ExplicitDelegator
      enforce_definitions :image, :name, :member_dashboard_path, :status_color, :status_description

      def image
        @delegate.image == '/assets/retina_thumb/missing.png' ? 'woople-theme/missing-profile.png' : @delegate.image
      end
    end
  end
end
