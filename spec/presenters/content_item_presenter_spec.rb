require_relative '../../app/presenters/content_item_presenter'
require_relative '../../spec/support/content_image_example'
require 'active_support/core_ext/object/blank'

describe ContentItemPresenter do
  let(:presenter) { ContentItemPresenter }
  include_examples 'content_image'

  describe "#certification_metadata" do
    describe "when null certification_metadata" do
      subject { ContentItemPresenter.new(stub(certification_metadata:nil)) }

      it "does not yield metadata" do
        called = false
        subject.certification_metadata { |metadata|
          called = true
        }
        called.should == false
      end
    end

    describe "when present certification_metadata" do
      subject { ContentItemPresenter.new(stub(certification_metadata:'data')) }

      it "yields metadata" do
        called = false

        subject.certification_metadata { |metadata| 
          metadata.should == 'data'
          called = true
        }

        called.should == true
      end
    end
  end

  describe "#completed_class" do
    describe "when the object is completed" do
      subject { ContentItemPresenter.new(stub(completed?: true)) }

      it "has a class of completed" do
        subject.completed_class.should == 'completed'
      end
    end

    describe "when the object is incompleted" do
      subject { ContentItemPresenter.new(stub(completed?: false)) }

      it "has a class of nil" do
        subject.completed_class.should be_nil
      end
    end
  end
end
