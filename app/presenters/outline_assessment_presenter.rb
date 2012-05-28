require 'delegate'

class OutlineAssessmentPresenter < SimpleDelegator
  def render
    css_class = "assessment"
    css_class << " disabled" unless startable?

    yield(css_class) if enabled?
  end
end
