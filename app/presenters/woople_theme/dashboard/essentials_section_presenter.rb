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

      private

      def render?(tab)
        tab.count > 0
      end

    end
  end
end
