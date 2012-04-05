module Paperclip
  class Attachment
    def initialize(url)
      @url = url
    end

    def to_s
      @url
    end
  end
end

shared_examples 'content_image' do
  describe "when there is no image property" do
    subject { get_presenter(stub) }

    it "does not yields the block if there is no image" do
      subject.image { "Hello world!" }.should be_nil
    end
  end

  describe "when there is a default paperclip image" do
    subject { get_presenter(stub(image:Paperclip::Attachment.new(ContentImage::MISSING_WOOPLE_IMAGE))) }

    it "yields the default image" do
      subject.image { |url| url }.should == ContentImage::DEFAULT_IMAGE
    end
  end

  describe "when there is a null image" do
    subject { get_presenter(stub(image:nil)) }

    it "yields the default image" do
      subject.image { |url| url }.should == ContentImage::DEFAULT_IMAGE
    end
  end

  describe "when there is an image" do
    subject { get_presenter(stub(image:'image.jpg')) }

    it "yields the specified image" do
      subject.image { |url| url }.should == 'image.jpg'
    end
  end

  private

  def get_presenter(model)
    presenter.new(model)
  end
end
