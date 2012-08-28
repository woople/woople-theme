require 'duration'
module WoopleTheme
  module Dashboard
    class CompletedEssentialPresenter < CompletedContentItemPresenter

      def date
        completed_on.strftime('%b %d')
      end

      def formatted_time_total
        Duration.format_time(time_total)
      end

    end
  end
end
