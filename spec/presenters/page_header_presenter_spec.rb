require_relative '../../app/presenters/page_header_presenter'
require_relative '../../spec/support/content_image_example'

describe PageHeaderPresenter do
  let(:presenter) { PageHeaderPresenter }
  include_examples 'content_image'

  describe "#title" do
    describe "when the object has a name" do
      subject { PageHeaderPresenter.new(stub(name: 'Name')) }

      it "should have a name" do
        subject.title.should == "Name"
      end
    end

    describe "when the object has a title" do
      subject { PageHeaderPresenter.new(stub(title: 'Title')) }

      it "should have the title" do
        subject.title.should == 'Title'
      end
    end
  end
end
