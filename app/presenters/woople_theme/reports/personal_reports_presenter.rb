require 'explicit_delegator'

module WoopleTheme
  module Reports
    class PersonalReportsPresenter < ExplicitDelegator
      enforce_definitions :reports

      def reports
        @reports ||= ThemePresentation.wrap_collection(@delegate.reports, WoopleTheme::Reports::PersonalReportPresenter)
      end
    end
  end
end
