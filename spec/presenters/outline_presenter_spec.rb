require_relative '../../app/presenters/outline_presenter'
require_relative '../../app/presenters/theme_presentation'

class OutlineDownloadPresenter < SimpleDelegator; end

describe OutlinePresenter do
  describe "#assessment" do
    describe "when there is an assesment" do
      describe "when the assessment is enabled" do
        subject { OutlinePresenter.new(stub(assessment:true, assessment_enabled?: true)) }

        it "yields the block" do
          called = false

          subject.assessment do |css_class|
            css_class.should == 'assessment'
            called = true
          end

          called.should == true
        end
      end

      describe "when the assessment is disabled" do
        subject { OutlinePresenter.new(stub(assessment:true, assessment_enabled?: false)) }

        it "yields the block as disabled" do
          called = false

          subject.assessment do |css_class|
            css_class.should == 'assessment disabled'
            called = true
          end

          called.should == true
        end
      end
    end

    describe "when there is no assessment "do
      subject { OutlinePresenter.new(stub(assessment:false)) }

      it "does not yield the block" do
        called = false

        subject.assessment do
          called = true
        end

        called.should == false
      end
    end
  end

  #NOTE: these two methods currently are very hard to test due to bugs in rails
  #      https://github.com/rails/rails/issues/5213
  #
  describe "#render_downloads" do; end
  describe "#render_videos" do; end
end

