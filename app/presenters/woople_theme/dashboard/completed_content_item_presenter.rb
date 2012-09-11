require 'woople_theme_i18n'

module WoopleTheme
  module Dashboard
    class CompletedContentItemPresenter < ExplicitDelegator

      def date
        WoopleThemeI18n.l(completed_on.to_date)
      end

    end
  end
end
