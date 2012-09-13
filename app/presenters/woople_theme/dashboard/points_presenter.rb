require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class PointsPresenter < ExplicitDelegator
      enforce_definitions :earned, :total

      def percent_complete
        return 100 if data.total.zero?

        ( (data.earned.to_f / data.total.to_f) * 100 ).round
      end

      private

      def data
        __getobj__
      end
    end
  end
end
