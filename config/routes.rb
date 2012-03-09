WoopleTheme::Application.routes.draw do
  resource :browse, controller: "browse" do
    member do
      get :course
    end
  end

  root :to => 'home#show'
end
