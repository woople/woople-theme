require_relative '../../app/presenters/outline_video_presenter'

describe OutlineVideoPresenter do
  describe "#css_class" do
    describe "when video is disabled and incomplete" do
      subject { presenter(stub(enabled:false, completed: false)) }

      it "is disabled" do
        subject.css_class.should == 'disabled'
      end
    end

    describe "when video is enabled and completed" do
      subject { presenter(stub(enabled:true, completed:true)) }

      it "is completed" do
        subject.css_class.should == 'completed'
      end
    end

    describe "when the video is not completed" do
      subject { presenter(stub(enabled:true, completed:false)) }

      it "has an empty css class" do
        subject.css_class.should be_empty
      end
    end
  end

  describe "#slug" do
    subject { presenter(stub(id: 123)) }
    its(:slug) { should == 'video_123' }
  end

  describe "#duration" do
    subject { presenter(stub(duration: 100000)) }
    its(:duration) { should == '1:40' }
  end

  describe "#completed" do
    describe "when the video is completed" do
      subject { presenter(stub(completed:true)) }

      it "yields" do
        called = false

        subject.completed { called = true }

        called.should == true
      end
    end

    describe "when the video is incomplete" do
      subject { presenter(stub(completed:false)) }

      it "doesn't yield" do
        called = false

        subject.completed { called = true }

        called.should == false
      end
    end
  end

  describe "#url" do
    describe "when the video is enabled" do
      subject { presenter(stub(enabled: true, url: 'blah')) }

      it "returns the proper url" do
        subject.url.should == 'blah'
      end
    end

    describe "when the video is disabled" do
      subject { presenter(stub(enabled:false, url: 'blah')) }

      it "does not return the url" do
        subject.url.should == '#'
      end
    end
  end

  private

  def presenter(model)
    OutlineVideoPresenter.new(model)
  end
end

