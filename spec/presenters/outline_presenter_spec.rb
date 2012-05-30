require_relative '../../app/presenters/outline_presenter'
require_relative '../../app/presenters/theme_presentation'

class OutlineDownloadPresenter < SimpleDelegator; end

describe OutlinePresenter do
  describe "#name" do
    subject { OutlinePresenter.new(stub(name: 'Channel')) }

    it "wraps the name inside a header tag" do
      subject.name.should == '<h2>Channel</h2>'
    end
  end

  #NOTE: these two methods currently are very hard to test due to bugs in rails
  #      https://github.com/rails/rails/issues/5213
  #
  #describe "#render_downloads" do; end
  #describe "#render_videos" do; end
end

