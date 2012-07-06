require 'explicit_delegator'

class AssessmentFormPresenter < ExplicitDelegator

  delegate_methods :description, # Short description of assessment
                   :course_path, # url to go to when assessment cancelled
                   :copyright,   # copyright notice for assessment
                   :submit_path, # path for assessment form to submit to
                   :questions    # set of questions in the assessment

  def render_copyright
    yield if copyright.present?
  end

  def questions
    ThemePresentation.wrap_collection(__getobj__.questions, QuestionPresenter)
  end

end