class AssessmentFormPresenter < SimpleDelegator
  def render_copyright
    yield if copyright.present?
  end
end