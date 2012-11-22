require 'spec_helper'

describe WoopleTheme::VideoPresenter do
  subject { WoopleTheme::VideoPresenter.new(stub_presenter) }

  describe '#favorite_css_class' do
    it "returns 'active' when favorited" do
      subject.stub favorite?: true
      subject.favorite_css_class.should eq 'active'
    end

    it 'returns nothing when unfavorited' do
      subject.stub favorite?: false
      subject.favorite_css_class.should eq ''
    end
  end

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

  private

  def stub_presenter(options = {})
    defaults = {name: nil, desktop_src: nil, mobile_src: nil, streamer: nil, favorite_id: nil, favorite?: nil, liked?: nil}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
