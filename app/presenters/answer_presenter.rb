require 'explicit_delegator'

class AnswerPresenter < ExplicitDelegator
  delegate_methods :index, # ID of the option to be used in the form
                   :text   # Text of the option/answer
end