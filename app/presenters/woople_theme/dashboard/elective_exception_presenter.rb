require 'woople_theme_i18n'

module WoopleTheme
  module Dashboard
    class ElectiveExceptionPresenter < ExceptionPresenter

      def subtitle
        I18n.t('woople_theme.dashboards.member.points', count: source.description, points: source.description)
      end

    end
  end
end
