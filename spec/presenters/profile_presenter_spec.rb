require_relative '../../app/presenters/profile_presenter'
require_relative '../../app/presenters/profile_section_presenter'
require_relative '../../app/presenters/theme_presentation'

describe ProfilePresenter do
  let(:presenter) { ProfilePresenter }

  describe "#image" do
    describe "when there is a default paperclip image" do
      subject { get_presenter(stub_presenter(image: ProfilePresenter::MISSING_WOOPLE_IMAGE)) }

      it "yields the default image" do
        subject.image { |url| url }.should == ProfilePresenter::DEFAULT_IMAGE
      end
    end

    describe "when there is a null image" do
      subject { get_presenter(stub_presenter(image:nil)) }

      it "yields the default image" do
        subject.image { |url| url }.should == ProfilePresenter::DEFAULT_IMAGE
      end
    end

    describe "when there is an image" do
      subject { get_presenter(stub_presenter(image:'image.jpg')) }

      it "yields the specified image" do
        subject.image { |url| url }.should == 'image.jpg'
      end
    end
  end

  describe "#sections" do
    subject { get_presenter(stub_presenter(sections: [stub, stub])) }

    it "wraps the section in the ProfileSectionPresenter" do
      subject.sections.each do |item|
        item.wrapped_by.should eq([ProfileSectionPresenter])
      end
    end
  end

  private

  def get_presenter(model)
    presenter.new(model)
  end

  def stub_presenter(options = {})
    defaults = {image: nil, sections: []}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
