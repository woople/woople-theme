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

  describe "#image_class" do
    describe "when the object has an image" do
      subject { PageHeaderPresenter.new(stub(image: 'image')) }

      it "has a class of page-header-with-image" do
        subject.image_class.should == 'page-header-with-image'
      end
    end

    describe "when the object does not have an image" do
      subject { PageHeaderPresenter.new(stub) }

      it "has a class of nil" do
        subject.image_class.should be_nil
      end
    end
  end

  describe "#completed_class" do
    describe "when the object is completed" do
      subject { PageHeaderPresenter.new(stub(completed?: true)) }

      it "has a class of completed" do
        subject.completed_class.should == 'completed'
      end
    end

    describe "when the object is incompleted" do
      subject { PageHeaderPresenter.new(stub(completed?: false)) }

      it "has a class of nil" do
        subject.completed_class.should be_nil
      end
    end
  end
end
