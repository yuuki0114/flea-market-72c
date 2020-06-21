Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: :index do
    collection do
      get 'logout', to: 'users#logout'
      get 'user_page', to: 'users#user_page'
      get 'personal_information', to: 'users#personal_information'
      get 'signup', to: 'users#signup'
      get 'login', to: 'users#login'
    end
  end
  resources :credit_cards, only: :new
  resources :items, only: [:show, :new]
  resources :buyers, only: :index
end