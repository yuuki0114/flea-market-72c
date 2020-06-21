Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: :index do
    collection do
      get 'logout', to: 'users#logout'
      get 'signup', to: 'users#signup'
      get 'login', to: 'users#login'
    end
  end
  resources :credit_cards, only: :new
  resources :items, only: [:show, :new]
  resources :buyers, only: :index
end