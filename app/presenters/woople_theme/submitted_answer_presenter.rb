require 'action_view'

module WoopleTheme
  class SubmittedAnswerPresenter < WoopleTheme::AnswerPresenter
    include ActionView::Helpers::TagHelper

    enforce_definitions :correct?,
                        :incorrect?,
                        :checked?

    def correct_badge
      content_tag(:span, I18n.t('woople_theme.assessment.correct'), class: "badge badge-success") if correct?
    end

    def incorrect_badge
      content_tag(:span, I18n.t('woople_theme.assessment.incorrect'), class: "badge badge-important") if incorrect?
    end

    def radio_disabled
      'disabled="disabled"'
    end

    def radio_checked
      'checked="checked"' if checked?
    end
  end
end
