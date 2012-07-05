require 'spec_helper'

describe QuestionPresenter do
  it "should have all of the delegated methods defined" do
    QuestionPresenter.instance_methods.should include(:id, :question, :answers)
  end

  it "should return a set of AnswerPresenters" do
    qp = QuestionPresenter.new(OpenStruct.new({answers:[{}]}))
    qp.answers.first.is_a?(AnswerPresenter).should be_true
  end

end
