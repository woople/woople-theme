require_relative '../../app/presenters/outline_assessment_presenter'
require_relative '../../app/presenters/theme_presentation'
require 'capybara'

describe OutlineAssessmentPresenter do
  describe "#render" do
    describe "when the assessment is enabled" do
      subject { OutlineAssessmentPresenter.new(stub_presenter(enabled?: true)) }

      specify { expect { |b| subject.render(&b) }.to yield_control }
    end

    describe "when the assessment is not enabled" do
      subject { OutlineAssessmentPresenter.new(stub_presenter(enabled?: false)) }

      specify { expect { |b| subject.render(&b) }.not_to yield_control }
    end
  end

  describe "#render_relearning" do
    describe "when there aren't relearnings" do
      subject { OutlineAssessmentPresenter.new(stub_presenter) }

      specify { expect { |b| subject.render_relearnings(&b) }.not_to yield_control }
    end

    describe "when there are relearnings" do
      subject { OutlineAssessmentPresenter.new(stub_presenter(relearnings: [stub])) }

      specify { expect { |b| subject.render_relearnings(&b) }.to yield_control }
    end
  end

  describe '#start_button_tag' do
    describe 'when the assessment is not startable' do
      subject { OutlineAssessmentPresenter.new(stub_presenter(startable?: false)) }

      it "should have a 'disabled' attribute" do
        page = Capybara::Node::Simple.new subject.start_button_tag
        page.should have_css 'input[type=submit].disabled'
        page.should have_css 'input[type=submit][disabled]'
      end
    end

    describe 'when the assessment is startable' do
      subject { OutlineAssessmentPresenter.new(stub_presenter(startable?: true)) }

      it "should not have a 'disabled' button" do
        page = Capybara::Node::Simple.new subject.start_button_tag
        page.should_not have_css 'input[type=submit].disabled'
        page.should_not have_css 'input[type=submit][disabled]'
      end
    end
  end

  describe "#render_history_link" do
    describe "when having history items" do
      subject { OutlineAssessmentPresenter.new(stub_presenter(history: [stub])) }

      specify { expect { |b| subject.render_history_link(&b) }.to yield_control }
    end

    describe "when no history items" do
      subject { OutlineAssessmentPresenter.new(stub_presenter) }

      specify { expect { |b| subject.render_history_link(&b) }.not_to yield_control }
    end
  end

  describe "#each_history_item" do
    before do
      WoopleThemeI18n.stub(:l) { |param| param }

      @first_history_item = stub(passed: false, score: 42, url: 'foo', completed_at: Date.parse('20120307')).as_null_object
      second_history_item = stub(passed: true).as_null_object
      assessment = OutlineAssessmentPresenter.new(stub_presenter(history: [@first_history_item, second_history_item]))
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
      subject { OutlineAssessmentPresenter.new(stub_presenter) }

      specify { expect { |b| subject.render_pass_fail_alert(&b) }.not_to yield_control }
    end

    describe "given 'passed?' is true" do
      subject { OutlineAssessmentPresenter.new(stub_presenter(passed?: true, history: [stub(url: '/foo').as_null_object])) }

      specify { expect { |b| subject.render_pass_fail_alert(&b) }.to yield_with_args(OpenStruct) }

      it 'yields an OpenStruct with pass alert entries' do
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
      subject { OutlineAssessmentPresenter.new(stub_presenter(passed?: false, history: [stub(url: '/foo').as_null_object])) }

      specify { expect { |b| subject.render_pass_fail_alert(&b) }.to yield_with_args(OpenStruct) }

      it 'yields an OpenStruct with fail alert entries' do
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
    subject { OutlineAssessmentPresenter.new(stub_presenter(completed?: true)) }

    it "should return 'completed' when the assessment is completed" do
      subject.completed_class.should eq("completed")
    end

    it "should return nil when the assessment is not completed" do
      subject.stub(:completed?) { false }

      subject.completed_class.should be_nil
    end
  end

  private

  def stub_presenter(options = {})
    defaults = {
      assessment_id: nil,
      enabled?: false,
      questions_asked: nil,
      pass_requirement: nil,
      estimated_duration: nil,
      startable?: false,
      url: nil,
      relearnings: [],
      history: [],
      completed?: false,
      passed?: nil
    }
    defaults.merge!(options)

    OpenStruct.new(defaults)
  end
end
