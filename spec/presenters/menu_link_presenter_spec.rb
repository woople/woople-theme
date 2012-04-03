require_relative '../../app/presenters/menu_link_presenter'
require_relative '../../app/presenters/theme_presentation'

describe MenuLinkPresenter do
  describe "#featured_tag" do
    describe "when the link is featured" do
      subject { wrap_link(stub(featured:true)) }

      it "is wrapped in the featured_tag" do
        subject.featured_tag('testing').should == '<em>testing</em>'
      end
    end

    describe "when the link is not featured" do
      subject { wrap_link(stub) }

      it "is not wrapped in the featured_tag" do
        subject.featured_tag('testing').should == 'testing'
      end
    end
  end

  describe "#badge" do
    describe "when there is a badge" do
      subject { wrap_link(stub(badge:'The badge')) }

      it "wraps the content in a badge tag" do
        subject.badge.should == "<span class=\"badge\">The badge</span>"
      end
    end

    describe "when there is no badge" do
      subject { wrap_link(stub) }

      it "returns an empty string" do
        subject.badge.should == ""
      end
    end
  end

  describe "#certification_badge" do
    describe "when there is a certification badge" do
      subject { wrap_link(stub(certification_badge:'red')) }

      it "wraps the content in a certification_badge" do
        subject.certification_badge.should == "<span class=\"badge label-icon\"><i class=\"cert-status-red\"></i> Red</span>"
      end
    end

    describe "when there is no certification badge" do
      subject { wrap_link(stub) }

      it "returns an empty string" do
        subject.certification_badge.should == ""
      end
    end
  end

  describe "#css_class" do
    describe "when link is selected" do
      subject { wrap_link(stub(selected:true)) }

      it "returns active" do
        subject.css_class.should == "active"
      end
    end

    describe "when link is not selected" do
      subject { wrap_link(stub) }

      it "returns nil" do
        subject.css_class.should be_nil
      end
    end
  end

  private

  def wrap_link(link)
    ThemePresentation.wrap(link, MenuLinkPresenter)
  end
end

