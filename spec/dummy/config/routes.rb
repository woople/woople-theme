Dummy::Application.routes.draw do
  match 'browse', to: 'browse#show'
  match 'search', to: 'browse#search'
  match 'course', to: 'browse#course'
  match 'course/video', to: 'browse#video'
  match 'framework', to: 'framework#show'
  match 'assessment', to: 'browse#assessment'
  match 'assessment_result', to: 'browse#assessment_result'

  root :to => 'browse#show'
end
