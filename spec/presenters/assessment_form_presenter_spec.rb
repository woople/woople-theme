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

  it "should return a set of QuestionPresenters" do
    afp = AssessmentFormPresenter.new(struct(obj))
    afp.questions.first.is_a?(WoopleTheme::QuestionPresenter).should be_true
  end

  describe '#render_copyright' do
    describe 'when the copyright is not present' do
      obj[:copyright] = ''
      assessment_form = AssessmentFormPresenter.new struct(obj)

      it 'does not yield' do
        yielded = false
        assessment_form.render_copyright { yielded = true }
        yielded.should == false
      end
    end

    describe 'when the copyright is present' do
      obj[:copyright] = 'Copyright (c) 2012 Apple Inc. All rights reserved.'
      assessment_form = AssessmentFormPresenter.new( struct(obj) )

      it 'yields' do
        yielded = false
        assessment_form.render_copyright { yielded = true }
        yielded.should == true
      end
    end
  end
end