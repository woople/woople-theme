WoopleTheme::Application.routes.draw do
  resource :browse, controller: "browse"
  root :to => 'home#show'
end
