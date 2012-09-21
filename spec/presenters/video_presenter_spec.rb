require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe WoopleTheme::VideoPresenter do
  obj = {
    desktop_src: nil,
    mobile_src: nil,
    streamer: nil,
    liked?: nil
  }

  subject { WoopleTheme::VideoPresenter.new(struct(obj)) }

  describe "#liked_css" do
    it "returns nothing" do
      subject.liked_css.should be_nil
    end

    it "returns 'active' when liked" do
      subject.stub(:liked?) { true }

      subject.liked_css.should eq('active')
    end

    it "returns nil when not liked" do
      subject.stub(:liked?) { false }

      subject.liked_css.should be_nil
    end
  end

  describe "#disliked_css" do
    it "returns nothing" do
      subject.disliked_css.should be_nil
    end

    it "returns 'active' when disliked" do
      subject.stub(:liked?) { false }

      subject.disliked_css.should eq('active')
    end

    it "returns nil when liked" do
      subject.stub(:liked?) { true }

      subject.disliked_css.should be_nil
    end
  end
end
