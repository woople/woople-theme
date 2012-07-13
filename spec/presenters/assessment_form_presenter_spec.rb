require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe AssessmentFormPresenter do
  obj = {
          questions: [{id: nil, question: nil, answers: nil}],
          description: nil,
          course_path: nil,
          copyright: nil,
          submit_path: nil
        }

  subject { AssessmentFormPresenter.new(struct(obj)) }

  describe "#title" do
    it "should render correctly" do
      presenter = AssessmentFormPresenter.new struct(obj)

      presenter.title.should eq(I18n.t('woople_theme.assessment.name'))
    end
  end

  describe "#css_classes" do
    it "has the right classes" do
      presenter = AssessmentFormPresenter.new(struct(obj))
      presenter.css_classes.should be_nil
    end
  end

  describe "#questions" do
    it "should return a set of QuestionPresenters" do
      presenter = AssessmentFormPresenter.new(struct(obj))
      presenter.questions.first.is_a?(WoopleTheme::QuestionPresenter).should be_true
    end
  end

  describe "#render_result_status" do
    it "rendering nothing" do
      expect { |block| subject.render_result_status &block }.to_not yield_control
    end
  end

  describe '#render_copyright' do
    describe 'when the copyright is not present' do
      obj[:copyright] = ''
      assessment_form = AssessmentFormPresenter.new struct(obj)

      it 'does not yield' do
        expect { |block| assessment_form.render_copyright &block }.to_not yield_control
      end
    end

    describe 'when the copyright is present' do
      obj[:copyright] = 'Copyright (c) 2012 Apple Inc. All rights reserved.'
      assessment_form = AssessmentFormPresenter.new( struct(obj) )

      it 'yields' do
        expect { |block| assessment_form.render_copyright &block }.to yield_control
      end
    end
  end

  describe "#footer_partial" do
    it "returns the correct partial name" do
      subject.footer_partial.should eq('woople-theme/assessment_form_submission')
    end
  end
end
