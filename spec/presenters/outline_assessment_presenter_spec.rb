require_relative '../../app/presenters/outline_assessment_presenter'
require_relative '../../app/presenters/theme_presentation'

describe OutlineAssessmentPresenter do
  describe "#render" do
    describe "when the assessment is enabled" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, enabled?: true).as_null_object) }

      it "yields the block" do
        called = false

        subject.render do
          called = true
        end

        called.should == true
      end
    end

    describe "when the assessment is not enabled" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, enabled?: false).as_null_object) }
    
      it "does not yield the block" do
        called = false
    
        subject.render do
          called = true
        end
    
        called.should == false
      end
    end
  end

  describe "#render_relearning" do
    describe "when there aren't relearnings" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, relearnings: [])) }

      it "shouldn't yield" do
        called = false
        
        subject.render_relearnings do
          called = true
        end
        
        called.should == false
      end
    end
    
    describe "when there are relearnings" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, relearnings: [stub])) }

      it "should yield" do
        called = false
        
        subject.render_relearnings do
          called = true
        end
        
        called.should == true
      end
    end
  end

  describe "#start_button_tag" do
    describe "when the assessment is not startable" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, url: nil)) }
      
      it "should have the disabled class" do
        subject.start_button_tag.should match('class="btn btn-primary btn-large disabled"')
      end

      it "should not have the href attribute" do
        subject.start_button_tag.should_not match('href=')
      end
    end
    
    describe "when the assessment is startable" do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, url: 'foo')) }
      
      it "should not have the disabled class" do
        subject.start_button_tag.should match('class="btn btn-primary btn-large"')
      end

      it "should have the href attribute" do
        subject.start_button_tag.should match('href="foo"')
      end
    end
  end

  describe "#history_link_tag" do
    describe 'when no history items' do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, history: [])) }

      it 'returns an empty string' do
        subject.history_link_tag.should be_blank
      end
    end

    describe 'when having history items' do
      subject { OutlineAssessmentPresenter.new(stub(:assessment, history: [stub])) }
      
      it 'returns a link' do
        subject.history_link_tag.should_not be_blank
      end
    end
  end

  describe "#each_history_item" do
    before do
      WoopleThemeI18n.stub(:l) { |param| param }
      
      @first_history_item = stub(passed: false, score: 42, url: 'foo', completed_at: Date.parse('20120307')).as_null_object
      second_history_item = stub(passed: true).as_null_object
      assessment = OutlineAssessmentPresenter.new(stub(:assessment, history: [@first_history_item, second_history_item]))
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
end
