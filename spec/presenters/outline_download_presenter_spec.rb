require_relative '../../app/presenters/outline_download_presenter'

describe OutlineDownloadPresenter do
  describe "#css_class" do
    describe "when enabled" do
      subject { OutlineDownloadPresenter.new(stub(enabled: true)) }

      it "returns download" do
        subject.css_class.should == 'download'
      end
    end

    describe "when disabled " do
      subject { OutlineDownloadPresenter.new(stub(enabled: false)) }

      it "returns disabled" do
        subject.css_class.should == 'download disabled'
      end
    end
  end

end
