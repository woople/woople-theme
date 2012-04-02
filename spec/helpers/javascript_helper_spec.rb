require 'spec_helper'
require_relative '../../app/helpers/javascript_helper'

describe JavascriptHelper, type: :helper do
  describe "#application_javascript" do
    describe "when a layout_javascript is specified" do
      it "returns a javascript_include_tag based on the configured layout_javascript" do
        WoopleTheme.configure do |config|
          config.layout_javascript = 'javascript'
        end

        html = helper.application_javascript
        html.should match /javascript/
        html.should match /script/
      end
    end

    describe "when no layout_javascript is specified" do
      it "does not return anything" do
        WoopleTheme.configure do |config|
          config.layout_javascript = nil
        end

        html = helper.application_javascript
        html.should be_nil
      end
    end

  end
end
