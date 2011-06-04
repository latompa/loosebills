Loosebills::Application.routes.draw do

  resources :withdrawals

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  resources :sessions
  
  root :to => 'home#index'

  # only to maintain demo
  match 'admin/reset_users'   => 'admin/demo#reset_users', :as => :reset_users
  match 'admin/restock_bills' => 'admin/demo#restock_bills', :as => :restock_bills

end
