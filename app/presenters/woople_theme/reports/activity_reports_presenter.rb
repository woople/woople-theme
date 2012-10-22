require 'explicit_delegator'

module WoopleTheme
  module Reports
    class ActivityReportsPresenter < ExplicitDelegator
      enforce_definitions :reports

      def reports
        @reports ||= ThemePresentation.wrap_collection(@delegate.reports, WoopleTheme::Reports::ActivityReportPresenter)
      end
    end
  end
end
