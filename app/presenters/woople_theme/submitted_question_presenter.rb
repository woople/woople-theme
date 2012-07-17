module WoopleTheme
  class SubmittedQuestionPresenter < WoopleTheme::QuestionPresenter
    def answers
      ThemePresentation.wrap_collection(__getobj__.answers, WoopleTheme::SubmittedAnswerPresenter)
    end
  end
end
