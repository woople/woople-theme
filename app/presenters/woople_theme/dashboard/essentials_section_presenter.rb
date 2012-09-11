require 'action_view'
module WoopleTheme
  module Dashboard
    class EssentialsSectionPresenter < SectionPresenter
      enforce_definitions :essentials_remaining,
                          :essentials_completed,
                          :essentials_exceptions

      def render_remaining
        yield if render?(section.essentials_remaining)
      end

      def render_completed
        yield if render?(section.essentials_completed)
      end

      def render_exceptions
        yield if render?(section.essentials_exceptions)
      end

      def total_completed_courses
        section.essentials_completed.count
      end

      def total_exceptions
        section.essentials_exceptions.count
      end

      def total_completed_minutes
        Duration.format_time(section.essentials_completed.map(&:time_total).inject(0, :+))
      end

      private

      def render?(tab)
        tab.count > 0
      end

    end
  end
end
