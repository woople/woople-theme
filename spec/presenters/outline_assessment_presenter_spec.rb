require_relative '../../app/presenters/outline_assessment_presenter'
require_relative '../../app/presenters/theme_presentation'
require 'capybara'

describe OutlineAssessmentPresenter do
  describe "#render" do
    describe "when the assessment is enabled" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, enabled?: true, completed?: false).as_null_object) }

      it "yields the block" do
        expect { |block| subject.render &block }.to yield_control
      end
    end

    describe "when the assessment is not enabled" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, enabled?: false, completed?: false).as_null_object) }

      it "does not yield the block" do
        expect { |block| subject.render &block }.to_not yield_control
      end
    end
  end

  describe "#render_relearning" do
    describe "when there aren't relearnings" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, relearnings: [], completed?: false, enabled?: true)) }

      it "shouldn't yield" do
        expect { |block| subject.render_relearnings &block }.to_not yield_control
      end
    end

    describe "when there are relearnings" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, relearnings: [stub], completed?: false, enabled?: true)) }

      it "should yield" do
        expect { |block| subject.render_relearnings &block }.to yield_control
      end
    end
  end

  describe '#start_button_tag' do
    describe 'when the assessment is not startable' do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, startable?: false, completed?: false, enabled?: true)) }

      it "should have a 'disabled' attribute" do
        page = Capybara::Node::Simple.new subject.start_button_tag
        page.should have_css 'input[type=submit].disabled'
        page.should have_css 'input[type=submit][disabled]'
      end
    end

    describe 'when the assessment is startable' do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, startable?: true, url: '/courses/foo', completed?: false, enabled?: true)) }

      it "should not have a 'disabled' button" do
        page = Capybara::Node::Simple.new subject.start_button_tag
        page.should_not have_css 'input[type=submit].disabled'
        page.should_not have_css 'input[type=submit][disabled]'
      end
    end
  end

  describe "#render_history_link" do
    describe "when having history items" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, history: [stub], enabled?: true, completed?: false).as_null_object) }

      it "yields the block" do
        expect { |block| subject.render_history_link &block }.to yield_control
      end
    end

    describe "when no history items" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, history: [], enabled?: false, completed?: false).as_null_object) }

      it "does not yield the block" do
        expect { |block| subject.render_history_link &block }.to_not yield_control
      end
    end
  end

  describe "#each_history_item" do
    before do
      WoopleThemeI18n.stub(:l) { |param| param }

      @first_history_item = stub(passed: false, score: 42, url: 'foo', completed_at: Date.parse('20120307')).as_null_object
      second_history_item = stub(passed: true).as_null_object
      assessment = OutlineAssessmentPresenter.new(stub(:assessment, history: [@first_history_item, second_history_item], completed?: false, enabled?: true))
      @processed = []
      assessment.each_history_item do |history_item|
        @processed << history_item
      end
    end

    it "has a result_name of 'Fail' if passed is false" do
      @processed.first.result_name.should == I18n.t('woople_theme.assessment.fail')
    end

    it "has a result_name of 'Pass' if passed is true" do
      @processed.second.result_name.should == I18n.t('woople_theme.assessment.pass')
    end

    it "adds the percent symbol to the end of the score" do
      @processed.first.score.should == '42%'
    end

    it "returns the url" do
      @processed.first.url.should == 'foo'
    end

    it "returns the formatted date" do
      @processed.first.date.should == WoopleThemeI18n.l(@first_history_item.completed_at)
    end
  end

  describe '#render_pass_fail_alert' do
    describe "given no 'passed?' key" do
      subject { OutlineAssessmentPresenter.new OpenStruct.new(completed?: false, enabled?: true) }

      it "doesn't yield" do
        expect { |block| subject.render_pass_fail_alert &block }.not_to yield_control
      end
    end

    describe "given 'passed?' is true" do
      subject { OutlineAssessmentPresenter.new(OpenStruct.new(passed?: true, history: [OpenStruct.new(url: '/foo')], completed?: false, enabled?: true)) }

      it 'yields an OpenStruct with pass alert entries' do
        expect { |block| subject.render_pass_fail_alert &block }.to yield_with_args OpenStruct
        subject.render_pass_fail_alert do |alert|
          alert.css_class.should == 'alert-success'
          alert.heading.should == WoopleThemeI18n.t('woople_theme.assessment.pass_alert.heading')
          alert.link.should == '/foo'
          alert.link_text.should == WoopleThemeI18n.t('woople_theme.assessment.pass_alert.link_text')
          alert.message.should == ''
        end
      end
    end

    describe "given 'passed?' is false" do
      subject { OutlineAssessmentPresenter.new(OpenStruct.new(passed?: false, history: [OpenStruct.new(url: '/foo')], completed?: false, enabled?: true)) }

      it 'yields an OpenStruct with fail alert entries' do
        expect { |block| subject.render_pass_fail_alert &block }.to yield_with_args OpenStruct
        subject.render_pass_fail_alert do |alert|
          alert.css_class.should == 'alert-error'
          alert.heading.should == WoopleThemeI18n.t('woople_theme.assessment.fail_alert.heading')
          alert.link.should == '/foo'
          alert.link_text.should == WoopleThemeI18n.t('woople_theme.assessment.fail_alert.link_text')
          alert.message.should == WoopleThemeI18n.t('woople_theme.assessment.fail_alert.message')
        end
      end
    end
  end

  describe "#completed_class" do
    subject { OutlineAssessmentPresenter.new(OpenStruct.new(completed?: true, enabled?: true)) }

    it "should return 'completed' when the assessment is completed" do
      subject.completed_class.should eq("completed")
    end

    it "should return nil when the assessment is not completed" do
      subject.stub(:completed?) { false }

      subject.completed_class.should be_nil
    end
  end
end
