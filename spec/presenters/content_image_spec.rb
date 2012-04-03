require_relative '../../app/presenters/content_image'
require 'delegate'

class DummyPresenter < SimpleDelegator; end

describe ContentImage do

  describe "when there is no image property" do
    subject { presenter(stub) }

    it "does not yields the block if there is no image" do
      subject.image { "Hello world!" }.should be_nil
    end
  end

  describe "when there is a null image" do
    subject { presenter(stub(image:nil)) }

    it "yields the default image" do
      subject.image { |url| url }.should == ContentImage::DEFAULT_IMAGE
    end
  end

  describe "when there is an image" do
    subject { presenter(stub(image:'image.jpg')) }

    it "yields the specified image" do
      subject.image { |url| url }.should == 'image.jpg'
    end
  end

  private

  def presenter(model)
    DummyPresenter.new(model).extend(ContentImage)
  end
end

