require 'action_view'
require 'woople_theme_i18n'

class SubmittedAssessmentFormPresenter < AssessmentFormPresenter
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TagHelper

  enforce_definitions :completed_at,
                      :passed?,
                      :correct_questions,
                      :score

  def title
    I18n.t('woople_theme.assessment.result')
  end

  def css_classes
    [:results]
  end

  def questions
    ThemePresentation.wrap_collection(__getobj__.questions, WoopleTheme::SubmittedQuestionPresenter)
  end

  def render_result_status
    status_message = I18n.t('woople_theme.assessment.result_status', {
      completed_at: WoopleThemeI18n.l(completed_at.to_date),
      status: status,
      correct_questions: correct_questions,
      total_questions: total_questions,
      score: number_to_percentage(score, :precision => 0),
      count: total_questions
    })

    yield OpenStruct.new(message: status_message, classes: result_status_classes)
  end

  def footer_partial
    'woople-theme/assessment_form_return'
  end

  def result_status_classes
    classes = [:alert, :fade, :in]
    classes << 'alert-success' if passed?
    classes << 'alert-error' if !passed?

    classes
  end

  def status
    passed? ? I18n.t('woople_theme.assessment.passed') : I18n.t('woople_theme.assessment.failed')
  end

  def total_questions
    questions.length
  end
end
