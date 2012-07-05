require 'spec_helper'

describe AnswerPresenter do
  it "should have all of the delegated methods defined" do
    AnswerPresenter.instance_methods.should include(:index, :text)
  end
end
