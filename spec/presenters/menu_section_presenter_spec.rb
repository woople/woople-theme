require_relative '../../app/presenters/menu_section_presenter'
require_relative '../../app/presenters/menu_link_presenter'
require_relative '../../app/presenters/menu_widget_presenter'
require_relative '../../app/presenters/theme_presentation'

describe MenuSectionPresenter do
  describe "#name" do
    describe "when name is not defined" do
      subject { ThemePresentation.wrap(stub, MenuSectionPresenter) }

      specify { expect {|b| subject.name(&b) }.not_to yield_control }
    end

    describe "when name is present" do
      subject { ThemePresentation.wrap(stub(name:'Bob'), MenuSectionPresenter) }

      specify { expect {|b| subject.name(&b) }.to yield_control }
    end
  end

  describe "#links" do
    describe "with links" do
      subject { ThemePresentation.wrap(stub(name:'Bob', links: [stub, stub, stub]), MenuSectionPresenter) }

      it "wraps each link in a MenuLinkPresenter" do
        subject.links.each do |link|
          link.wrapped_by.should eq([MenuLinkPresenter])
        end
      end
    end

    describe "without links" do
      subject { ThemePresentation.wrap(stub(name:'Bob'), MenuSectionPresenter) }

      it "returns an empty array" do
        subject.links.should eq([])
      end
    end
  end

  describe "#widgets" do
    describe "with widgets" do
      subject { ThemePresentation.wrap(stub(name:'Bob', widgets: [stub(partial_path: '', model: {})]), MenuSectionPresenter) }

      it "wraps each widget in a MenuWidgetPresenter" do
        subject.widgets.each do |widget|
          widget.wrapped_by.should eq([MenuWidgetPresenter])
        end
      end
    end

    describe "without widgets" do
      subject { ThemePresentation.wrap(stub(name:'Bob'), MenuSectionPresenter) }

      it "returns an empty array" do
        subject.widgets.should eq([])
      end
    end
  end
end
