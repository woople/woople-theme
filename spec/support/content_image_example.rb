shared_examples 'content_image' do
  describe "when there is a default paperclip image" do
    subject { get_presenter(stub_presenter(image:ContentImage::MISSING_WOOPLE_IMAGE)) }

    it "yields the default image" do
      subject.image { |url| url }.should == ContentImage::DEFAULT_IMAGE
    end
  end

  describe "when there is a null image" do
    subject { get_presenter(stub_presenter(image:nil)) }

    it "yields the default image" do
      subject.image { |url| url }.should == ContentImage::DEFAULT_IMAGE
    end
  end

  describe "when there is an image" do
    subject { get_presenter(stub_presenter(image:'image.jpg')) }

    it "yields the specified image" do
      subject.image { |url| url }.should == 'image.jpg'
    end
  end

  private

  def get_presenter(model)
    presenter.new(model)
  end

  def stub_presenter(options = {})
    defaults = {name: 'Content Item', url: '/course', image: nil}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
