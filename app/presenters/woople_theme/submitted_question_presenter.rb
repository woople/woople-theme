module WoopleTheme
  class SubmittedQuestionPresenter < WoopleTheme::QuestionPresenter
    def answers
      ThemePresentation.wrap_collection(@delegate.answers, WoopleTheme::SubmittedAnswerPresenter)
    end
  end
end
