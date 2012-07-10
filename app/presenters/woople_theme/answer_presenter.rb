require 'explicit_delegator'

module WoopleTheme
  class AnswerPresenter < ExplicitDelegator
    enforce_definitions :index, # ID of the option to be used in the form
                        :text   # Text of the option/answer
  end
end

