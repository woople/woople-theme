require 'explicit_delegator'

class AssessmentFormPresenter < ExplicitDelegator
  enforce_definitions :description, # Short description of assessment
                      :course_path, # url to go to when assessment cancelled
                      :copyright,   # copyright notice for assessment
                      :submit_path, # path for assessment form to submit to
                      :questions    # set of questions in the assessment

  def title
    I18n.t('woople_theme.assessment.name')
  end

  def css_classes
    nil
  end

  def questions
    ThemePresentation.wrap_collection(assessment_result.questions, WoopleTheme::QuestionPresenter)
  end

  def render_result_status
    nil
  end

  def render_copyright
    yield if copyright.present?
  end

  def footer_partial
    'woople-theme/assessment_form_submission'
  end

  private

  def assessment_result
    @delegate
  end
end
