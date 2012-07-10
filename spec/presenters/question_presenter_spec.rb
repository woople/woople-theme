require 'spec_helper'

describe WoopleTheme::QuestionPresenter do
  it "should return a set of AnswerPresenters" do
    qp = WoopleTheme::QuestionPresenter.new(OpenStruct.new({id: "", question: "", answers:[{index: "", text: ""}]}))
    qp.answers.first.is_a?(WoopleTheme::AnswerPresenter).should be_true
  end

end
