module WoopleTheme
  module Dashboard
    class UserAndStatusPresenter < ExplicitDelegator
      enforce_definitions :image, :name, :status_color, :status_description

      def image
        @delegate.image == '/assets/retina_thumb/missing.png' ? 'woople-theme/missing-profile.png' : @delegate.image
      end
    end
  end
end
