require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe WoopleTheme::QuestionPresenter do
  obj = {
    id: 1,
    question: nil,
    answers: [
      {
        index: 2,
        text: nil
      }
    ]
  }

  describe "#answers" do
    it "should return a set of AnswerPresenters" do
      presenter = WoopleTheme::QuestionPresenter.new(struct(obj))
      presenter.answers.first.should be_an_instance_of(WoopleTheme::AnswerPresenter)
    end
  end

end
