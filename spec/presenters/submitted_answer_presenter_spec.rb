require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe WoopleTheme::SubmittedAnswerPresenter do
  obj = {
    index: nil,
    text: nil,
    correct?: false,
    incorrect?: false,
    checked?: false
  }

  subject { WoopleTheme::SubmittedAnswerPresenter.new(struct(obj)) }

  describe "#correct_badge" do
    it "renders correctly when answer is correct" do
      subject.stub(:correct?) { true }

      html = Capybara::Node::Simple.new(subject.correct_badge)
      html.should have_content(I18n.t('woople_theme.assessment.correct'))
      html.should have_css(".badge.badge-success")
    end

    it "renders nothing when answer is not correct" do
      subject.correct_badge.should be_nil
    end
  end

  describe "#incorrect_badge" do
    it "renders correctly when answer is incorrect" do
      subject.stub(:incorrect?) { true }

      html = Capybara::Node::Simple.new(subject.incorrect_badge)
      html.should have_content(I18n.t('woople_theme.assessment.incorrect'))
      html.should have_css(".badge.badge-important")
    end

    it "renders nothing when presenter is not incorrect" do
      subject.incorrect_badge.should be_nil
    end
  end

  describe "#radio_disabled" do
    it "renders correctly" do
      subject.radio_disabled.should eq('disabled="disabled"')
    end
  end

  describe "#radio_checked" do
    it "renders correctly" do
      subject.stub(:checked?) { true }

      subject.radio_checked.should eq('checked="checked"')
    end
  end
end
