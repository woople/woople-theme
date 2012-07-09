require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe WoopleTheme::AnswerPresenter do
  obj = {
    index: nil,
    text: nil
  }

  subject { WoopleTheme::AnswerPresenter.new(struct(obj)) }

  describe "#correct_badge" do
    it "renders nothing" do
      subject.correct_badge.should be_nil
    end
  end

  describe "#incorrect_badge" do
    it "renders nothing" do
      subject.incorrect_badge.should be_nil
    end
  end

  describe "#radio_disabled" do
    it "renders nothing" do
      subject.radio_disabled.should be_nil
    end
  end

  describe "#radio_checked" do
    it "renders nothing" do
      subject.radio_checked.should be_nil
    end
  end
end
