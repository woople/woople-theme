require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class SectionPresenter < ExplicitDelegator
      enforce_definitions :enabled?

      def render
        yield if section.enabled?
      end

      private

      def section
        __getobj__
      end
    end
  end
end
