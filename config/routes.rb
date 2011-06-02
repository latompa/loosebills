Loosebills::Application.routes.draw do

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  resources :sessions
  
  root :to => 'home#index'
  
end
