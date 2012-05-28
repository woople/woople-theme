require_relative '../../app/presenters/outline_assessment_presenter'
require_relative '../../app/presenters/theme_presentation'

describe OutlineAssessmentPresenter do
  describe "#render" do
    describe "when there is an assesment" do
      describe "when the assessment is enabled" do
        subject { OutlineAssessmentPresenter.new(stub(:assessment, enabled?: true).as_null_object) }

        it "yields the block" do
          called = false

          subject.render do |css_class|
            css_class.should == 'assessment'
            called = true
          end

          called.should == true
        end
      end

      describe "when the assessment is not startable" do
        subject { OutlineAssessmentPresenter.new(stub(:assessment, enabled?: true, startable?: false)) }
      
        it "yields the block as disabled" do
          called = false
      
          subject.render do |css_class|
            css_class.should == 'assessment disabled'
            called = true
          end
      
          called.should == true
        end
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
end
