require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class StatusAlertPresenter < ExplicitDelegator
      enforce_definitions :color, :description

      def css_class
        case @delegate.color
        when :red
          'alert-error'
        when :green
          'alert-success'
        end
      end

      def color
        @delegate.color.to_s.capitalize!
      end
    end
  end
end
