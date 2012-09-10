require 'woople_theme_i18n'

module WoopleTheme
  module Dashboard
    class ElectiveHistoryPresenter < ContentItemPresenter
      include ContentImage

      enforce_definitions :completed_on,
                          :current_points,
                          :total_points

      def render_time_remaining(&block)
      end

      def render_popularity(&block)
      end

      def render_certification_metadata(&block)
      end

      def render_progress_bar(&block)
      end

      def render_elective_points(&block)
        yield(points_metadata)
      end

      def render_completed_on(&block)
        yield(formatted_date)
      end

      private

      def formatted_date
        WoopleThemeI18n.l(completed_on.to_date)
      end

      def points_metadata
        if in_progress?
          I18n.t('woople_theme.dashboards.member.points', count: total_points, points: "#{current_points}/#{total_points}")
        else
          I18n.t('woople_theme.dashboards.member.points', count: total_points, points: total_points)
        end
      end

      def in_progress?
        current_points < total_points
      end

    end
  end
end
