require 'explicit_delegator'

module WoopleTheme
  class QuestionPresenter < ExplicitDelegator
    enforce_definitions :id,       # Response id used in the form
                        :question, # Text of the question
                        :answers   # Set of options/answers for the question

    def answers
      ThemePresentation.wrap_collection(__getobj__.answers, WoopleTheme::AnswerPresenter)
    end

  end
end
