require 'action_view'
module WoopleTheme
  module Dashboard
    class EssentialsSectionPresenter < SectionPresenter
      enforce_definitions :essentials_remaining

      def render_remaining
        yield if section.essentials_remaining.size > 0
      end

    end
  end
end
