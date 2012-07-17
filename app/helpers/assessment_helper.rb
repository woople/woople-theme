module AssessmentHelper
  def assessment_form(presenter, options = { submitted?: false })
    form_presenter = options[:submitted?] ? SubmittedAssessmentFormPresenter : AssessmentFormPresenter

    render partial: 'woople-theme/assessment_form', object: ThemePresentation.wrap(presenter, form_presenter)
  end
end
