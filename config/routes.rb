Loosebills::Application.routes.draw do

  resources :withdrawals

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  resources :sessions
  
  root :to => 'home#index'
  
end
