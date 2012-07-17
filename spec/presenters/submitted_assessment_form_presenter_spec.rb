require 'spec_helper'

def struct(obj_in)
  OpenStruct.new(obj_in)
end

describe SubmittedAssessmentFormPresenter do
  obj = {
    questions: [{id: nil, question: nil, answers: nil}],
    description: nil,
    course_path: nil,
    copyright: nil,
    submit_path: nil,
    completed_at: Time.current,
    passed?: false,
    correct_questions: 5,
    score: 75
  }

  subject { SubmittedAssessmentFormPresenter.new(struct(obj)) }

  describe "#title" do
    it "should render correctly" do
      presenter = SubmittedAssessmentFormPresenter.new struct(obj)

      presenter.title.should eq(I18n.t('woople_theme.assessment.result'))
    end
  end

  describe "#css_classes" do
    it "has the right classes" do
      presenter = SubmittedAssessmentFormPresenter.new(struct(obj))
      presenter.css_classes.should eq([:results])
    end
  end

  describe "#questions" do
    it "should return a set of SubmittedQuestionPresenters" do
      presenter = SubmittedAssessmentFormPresenter.new(struct(obj))
      presenter.questions.first.is_a?(WoopleTheme::SubmittedQuestionPresenter).should be_true
    end
  end

  describe "#render_result_status" do
    it "rendering correctly" do
      expect { |block| subject.render_result_status &block }.to yield_with_args OpenStruct

      #On Jul 12 2012 you failed this assessment by answering 5/1 question correctly for a 75% score.
      status_message = I18n.t('woople_theme.assessment.result_status', {
        completed_at: WoopleThemeI18n.l(subject.completed_at.to_date),
        status: subject.status,
        correct_questions: subject.correct_questions,
        total_questions: subject.total_questions,
        score: "#{subject.score}%",
        count: subject.total_questions
      })

      subject.render_result_status do |result|
        result.message.should eq(status_message)
        result.classes.should include('alert-error')
      end
    end
  end

  describe "#footer_partial" do
    it "returns the correct partial name" do
      subject.footer_partial.should eq('woople-theme/assessment_form_return')
    end
  end

  describe "#result_status_classes" do
    it "should contain alert-success when the result is passed" do
      subject.stub(:passed?) { true }

      subject.result_status_classes.should include('alert-success')
    end

    it "should contain alert-error when the result is not passed" do
      subject.result_status_classes.should include('alert-error')
    end
  end

  describe "#status" do
    it "returns passed when the result is passed" do
      subject.stub(:passed?) { true }

      subject.status.should eq(I18n.t('woople_theme.assessment.passed'))
    end

    it "returns failed when the result is not passed" do
      subject.status.should eq(I18n.t('woople_theme.assessment.failed'))
    end
  end

  describe "#total_questions" do
    it "returns the number of questions" do
      subject.total_questions.should eq(1)
    end
  end
end
