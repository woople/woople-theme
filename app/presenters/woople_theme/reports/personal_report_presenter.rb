require 'forwardable'
require 'action_view/helpers/url_helper'
require 'explicit_delegator'

module WoopleTheme
  module Reports
    class PersonalReportPresenter < ExplicitDelegator
      include ActionView::Helpers::UrlHelper

      enforce_definitions :name, :type, :data_path, :download_path

      DAILY_LEGEND   = ['0-3', '4-6', '7+']
      WEEKLY_LEGEND  = ['0-28', '29-48', '49+']
      MONTHLY_LEGEND = ['0-123', '124-216', '217+']

      def report_link
        link_to(
          name,
          href,
          {
            data: {
              toggle: 'tab',
              type: type,
              container: container,
              path: data_path
            }
          }
        )
      end

      def name
        report.name.titleize
      end

      def tab_name
        report.type.downcase
      end

      def href
        "##{tab_name}"
      end

      def container
        "#{tab_name}_report_chart"
      end

      def legend
        return DAILY_LEGEND if daily?
        return WEEKLY_LEGEND if weekly?
        return MONTHLY_LEGEND if monthly?
      end

      def chart_title
        return I18n.t('woople_theme.reports.chart.titles.daily') if daily?
        return I18n.t('woople_theme.reports.chart.titles.weekly') if weekly?
        return I18n.t('woople_theme.reports.chart.titles.monthly') if monthly?
      end

      def daily?
        report.type.to_s == 'week'
      end

      def weekly?
        report.type.to_s == 'month'
      end

      def monthly?
        report.type.to_s == 'annual'
      end

      private

      def report
        @delegate
      end
    end
  end
end
