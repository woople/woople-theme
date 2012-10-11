Dummy::Application.routes.draw do
  match 'framework',              to: 'framework#show'
  match 'course',                 to: 'browse#course'
  match 'video',                  to: 'browse#video'
  match 'search',                 to: 'browse#search'
  match 'assessment',             to: 'browse#assessment'
  match 'assessment-result',      to: 'browse#assessment_result'
  match 'member-dashboard',       to: 'browse#member_dashboard'
  match 'organization-dashboard', to: 'browse#organization_dashboard'
  match 'report/personal',        to: 'browse#personal_report'
  match 'report/personal/data',   to: 'browse#personal_report', as: :personal_report_data

  root :to => 'browse#show'
end
