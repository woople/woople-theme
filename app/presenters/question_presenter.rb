require 'explicit_delegator'

class QuestionPresenter < ExplicitDelegator
  delegate_methods :id,       # Response id used in the form
                   :question, # Text of the question
                   :answers  # Set of options/answers for the question

  def answers
    ThemePresentation.wrap_collection(__getobj__.answers, AnswerPresenter)
  end

end
