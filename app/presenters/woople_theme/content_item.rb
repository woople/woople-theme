require 'explicit_delegator'

module WoopleTheme
  class ContentItem < ExplicitDelegator
    enforce_definitions :name, :url, :image, :completed?, :completed_on, :time_remaining, :time_total,
                        :popularity, :percent_complete, :certification_metadata, :current_points, :total_points
  end
end
