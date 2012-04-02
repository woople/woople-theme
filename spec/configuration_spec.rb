require 'spec_helper'

describe WoopleTheme::Configuration do
  describe "#profile_helper" do
    describe "when nothing is specified" do
      before do
        WoopleTheme.configure { |config| }
      end

      it "defaults to :profile_model" do
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


end
