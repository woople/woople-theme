require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe WoopleTheme::SubmittedQuestionPresenter do
  obj = {
    id: 1,
    question: nil,
    answers: [
      {
        index: 2,
        text: nil,
        correct?: false,
        incorrect?: false,
        checked?: false
      }
    ]
  }

  describe "#answers" do
    it "should return a set of SubmittedAnswerPresenters" do
      presenter = WoopleTheme::SubmittedQuestionPresenter.new(struct(obj))
      presenter.answers.first.should be_an_instance_of(WoopleTheme::SubmittedAnswerPresenter)
    end
  end
end
