WoopleTheme::Application.routes.draw do
  match 'browse', to: 'browse#show'
  match 'browse/course', to: 'browse#course'
  match 'browse/course/video', to: 'browse#video'

  root :to => 'home#show'
end
