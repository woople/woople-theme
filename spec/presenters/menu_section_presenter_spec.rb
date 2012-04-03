require_relative '../../app/presenters/menu_section_presenter'
require_relative '../../app/presenters/menu_link_presenter'
require_relative '../../app/presenters/theme_presentation'

describe MenuSectionPresenter do
  describe "#name" do
    describe "when name is not defined" do
      subject { ThemePresentation.wrap(stub, MenuSectionPresenter) }

      it "does not yield the name" do
        called = false
        subject.name { called = true }
        called.should == false
      end
    end

    describe "when name is present" do
      subject { ThemePresentation.wrap(stub(name:'Bob'), MenuSectionPresenter) }

      it "yields the name" do
        called = false
        subject.name { |name|
          name.should == 'Bob'
          called = true
        }

        called.should == true
      end
    end
  end

  describe "#links" do
    it "wraps each link in a MenuLinkPresenter" do
      section = ThemePresentation.wrap(stub(name: 'Bob', links: [stub, stub, stub]), MenuSectionPresenter)

      section.links.each do |link|
        link.wrapped_by.should == [MenuLinkPresenter]
      end
    end
  end
end
