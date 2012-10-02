require 'woople_theme_i18n'

module WoopleTheme
  module Dashboard
    class ExceptionPresenter < ExplicitDelegator
      enforce_definitions :name, :description, :completed_on

      def title
        source.name
      end

      def subtitle
        raise "not implemented"
      end

      def date
        WoopleThemeI18n.l(source.completed_on.to_date)
      end

      private

      def source
        @delegate
      end

    end
  end
end
