require 'spec_helper'

describe AssessmentFormPresenter do
  it "should have all of the delegated methods defined" do
    AssessmentFormPresenter.instance_methods.should include(:description, :course_path, :copyright, :submit_path, :questions)
  end

  it "should return a set of QuestionPresenters" do
    afp = AssessmentFormPresenter.new(OpenStruct.new({questions:[{}]}))
    afp.questions.first.is_a?(QuestionPresenter).should be_true
  end

  describe '#render_copyright' do
    describe 'when the copyright is not present' do
      subject { AssessmentFormPresenter.new stub(copyright: '') }

      it 'does not yield' do
        yielded = false
        subject.render_copyright { yielded = true }
        yielded.should == false
      end
    end

    describe 'when the copyright is present' do
      subject { AssessmentFormPresenter.new stub(copyright: 'Copyright (c) 2012 Apple Inc. All rights reserved.') }

      it 'yields' do
        yielded = false
        subject.render_copyright { yielded = true }
        yielded.should == true
      end
    end
  end
end