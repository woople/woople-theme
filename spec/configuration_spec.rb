require 'spec_helper'

describe WoopleTheme::Configuration do
  describe "when no profile_helper is specified" do
    before do
      WoopleTheme.configure do |config|

      end
    end

    it "defaults to :profile_model" do
      WoopleTheme.configuration.profile_helper.should == :profile_helper
    end
  end
end
