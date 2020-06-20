Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: :index do
    collection do
      get 'logout', to: 'users#logout'
    end
  end
  resources :credit_cards, only: :new
  resources :items, only: :show
  resources :buyers, only: :index
end