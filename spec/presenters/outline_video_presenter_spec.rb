require_relative '../../app/presenters/outline_video_presenter'

describe OutlineVideoPresenter do
  describe "#css_class" do
    describe "when video is disabled and incomplete" do
      subject { presenter(enabled:false, completed: false) }

      it "is disabled" do
        subject.css_class.should == 'disabled'
      end
    end

    describe "when video is enabled and completed" do
      subject { presenter(enabled:true, completed:true) }

      it "is completed" do
        subject.css_class.should == 'completed'
      end
    end

    describe "when the video is not completed" do
      subject { presenter(enabled:true, completed:false) }

      it "has an empty css class" do
        subject.css_class.should be_empty
      end
    end
  end

  describe "#slug" do
    subject { presenter(id: 123) }
    its(:slug) { should == 'video_123' }
  end

  describe "#duration" do
    subject { presenter(duration: 100000) }
    its(:duration) { should == '1:40' }
  end

  describe "#url" do
    describe "when the video is enabled" do
      subject { presenter(enabled: true, url: 'blah') }

      it "returns the proper url" do
        subject.url.should == 'blah'
      end
    end

    describe "when the video is disabled" do
      subject { presenter(enabled:false, url: 'blah') }

      it "does not return the url" do
        subject.url.should == '#'
      end
    end
  end

  describe "#playback_class" do
    describe "when completed" do
      subject { presenter(completed: true) }

      specify { subject.playback_class.should eq("icon-ok") }
    end

    describe "when enabled" do
      subject { presenter(enabled: true) }

      specify { subject.playback_class.should eq("icon-play") }
    end

    describe "when incomplete and disabled" do
      subject { presenter(completed: false, enabled: false) }

      specify { subject.playback_class.should eq("icon-lock") }
    end
  end

  describe "#playback_icon" do
    subject { presenter(completed: true) }

    it "should create an icon element" do
      subject.playback_icon.should eq("<i class=\"icon-ok\"></i>")
    end
  end

  describe "#linkable?" do
    describe "when completed" do
      subject { presenter(completed: true) }

      specify { subject.linkable?.should eq(true) }
    end

    describe "when enabled" do
      subject { presenter(enabled: true) }

      specify { subject.linkable?.should eq(true) }
    end

    describe "when incomplete and disabled" do
      subject { presenter(completed: false, enabled: false) }

      specify { subject.linkable?.should eq(false) }
    end
  end

  describe "#render_description" do
    describe "when description is nil" do
      subject { presenter(description: nil) }

      specify { expect {|b| subject.render_description(&b) }.not_to yield_control }
    end

    describe "when description is not nil" do
      subject { presenter(description: 'example') }

      specify { expect {|b| subject.render_description(&b) }.to yield_control }
    end
  end

  describe "#render_now_playing" do
    describe "when now_playing is nil or false" do
      subject { presenter(now_playing?: [nil, false].sample) }

      specify { expect {|b| subject.render_now_playing(&b) }.not_to yield_control }
    end

    describe "when now_playing is true" do
      subject { presenter(now_playing?: true) }

      specify { expect {|b| subject.render_now_playing(&b) }.to yield_control }
    end
  end

  private

  def presenter(data)
    OutlineVideoPresenter.new(stub_presenter(data))
  end

  def stub_presenter(options = {})
    defaults = {id: nil, name: nil, description: nil, completed: nil, duration: nil, enabled: nil, url: '#', now_playing?: nil}
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
