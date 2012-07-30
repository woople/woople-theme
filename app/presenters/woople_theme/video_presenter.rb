require 'explicit_delegator'

module WoopleTheme
  class VideoPresenter < ExplicitDelegator
    enforce_definitions :src,   # path to the video
                        :liked? # does the user like this video (default: nil)

    def liked_css
      liked? == true ? 'active' : nil
    end

    def disliked_css
      liked? == false ? 'active' : nil
    end
  end
end
