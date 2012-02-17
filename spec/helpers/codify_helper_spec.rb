require 'spec_helper'

describe CodifyHelper do
  describe "#codify" do
    let(:content) { "<p>Hello World!</p>" }
    let(:html) { helper.codify { content } }

    subject { Capybara::Node::Simple.new(html) }

    it { should have_selector('div.codify') }

    context "the html preview" do
      it { should have_selector('div.codify > div.well') }

      it "should have the original content in the well" do
        subject.find('div.well').should have_content(content)
      end
    end

    context "the code example" do
      it { should have_selector('div.codify > pre.prettyprint') }

      it "should have the content code example" do
        subject.find('pre.prettyprint').should have_content(CGI.escapeHTML(content))
      end
    end

    it { should have_selector('div.codify > a.show_source') }
    it "has a show source link at the bottom" do
      subject.find('a.show_source').should have_content('Show Source')
    end
  end
end
