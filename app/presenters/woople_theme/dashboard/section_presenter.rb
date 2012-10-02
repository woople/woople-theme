require 'explicit_delegator'

module WoopleTheme
  module Dashboard
    class SectionPresenter < ExplicitDelegator
      enforce_definitions :enabled?

      def render
        yield if @delegate.enabled?
      end
    end
  end
end
