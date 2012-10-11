require 'woople_theme_i18n'

module WoopleTheme
  module Dashboard
    class EssentialCompletedPresenter < ContentItemPresenter
      enforce_definitions :completed_on, :time_total

      def render_time_remaining(&block)
      end

      def render_popularity(&block)
      end

      def render_certification_metadata(&block)
      end

      def render_progress_bar(&block)
      end

      def render_completed_on(&block)
        yield(formatted_date) unless source.completed_on.nil?
      end

      def render_essential_duration(&block)
        yield(source.time_total)
      end

      private

      def formatted_date
        WoopleThemeI18n.l(source.completed_on.to_date)
      end
    end
  end
end
