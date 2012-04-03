require_relative '../../app/presenters/outline_download_presenter'

describe OutlineDownloadPresenter do
  describe "#css_class" do
    describe "when enabled" do
      subject { OutlineDownloadPresenter.new(stub(enabled: true)) }

      it "returns nil" do
        subject.css_class.should == nil
      end
    end

    describe "when disabled " do
      subject { OutlineDownloadPresenter.new(stub(enabled: false)) }

      it "returns disabled" do
        subject.css_class.should == 'disabled'
      end
    end
  end

end
