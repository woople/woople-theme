require 'spec_helper'

describe WoopleTheme::Configuration do
  describe "#profile_helper" do
    describe "when nothing is specified" do
      before do
        WoopleTheme.configure do |config|
          config.profile_helper = nil
        end
      end

      it "defaults to :profile_helper" do
        WoopleTheme.configuration.profile_helper.should == :profile_helper
      end
    end

    describe "when a custom profile_helper is specified" do
      before do
        WoopleTheme.configure do |config|
          config.profile_helper = :profile_model
        end
      end

      it "is used instead of the default" do
        WoopleTheme.configuration.profile_helper.should == :profile_model
      end
    end
  end

  describe "#menu_helper" do
    describe "when nothing is specified" do
      before do
        WoopleTheme.configure do |config|
          config.menu_helper = nil
        end
      end

      it "defaults to :menu_helper" do
        WoopleTheme.configuration.menu_helper.should == :menu_helper
      end
    end

    describe "when a custom menu_helper is specified" do
      before do
        WoopleTheme.configure do |config|
          config.menu_helper = :menu_model
        end
      end

      it "is used instead of the default" do
        WoopleTheme.configuration.menu_helper.should == :menu_model
      end
    end
  end

  describe "#layout_javascript" do
    describe "when nothing is specified" do
      before do
        WoopleTheme.configure do |config|
          config.layout_javascript = nil
        end
      end

      it "is nil" do
        WoopleTheme.configuration.layout_javascript.should be_nil
      end
    end

    describe "when a custom javascript layout is specified" do
      before do
        WoopleTheme.configure do |config|
          config.layout_javascript = 'javascript'
        end
      end

      it "is used instead of the default" do
        WoopleTheme.configuration.layout_javascript.should == 'javascript'
      end
    end
  end
end
