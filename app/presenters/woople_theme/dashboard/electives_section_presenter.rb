require 'action_view'
module WoopleTheme
  module Dashboard
    class ElectivesSectionPresenter < SectionPresenter
      enforce_definitions :electives_history,
                          :electives_exceptions

      def render_history
        yield if render?(section.electives_history)
      end

      def render_exceptions
        yield if render?(section.electives_exceptions)
      end

      private

      def render?(tab)
        tab.count > 0
      end
    end
  end
end
