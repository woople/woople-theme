Dummy::Application.routes.draw do
  match 'browse', to: 'browse#show'
  match 'course', to: 'browse#course'
  match 'course/video', to: 'browse#video'
  match 'framework', to: 'framework#show'

  root :to => 'browse#show'
end
