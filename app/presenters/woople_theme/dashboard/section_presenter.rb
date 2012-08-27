require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class SectionPresenter < ExplicitDelegator
      enforce_definitions :title,
                          :enabled?

      def render
        yield if section.enabled?
      end

      def title
        section.title.titleize
      end

      def css_id
        section.title.parameterize + "-section"
      end

      private

      def section
        __getobj__
      end
    end
  end
end
