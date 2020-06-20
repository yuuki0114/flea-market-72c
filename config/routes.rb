Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: :index do
    collection do
      get 'logout', to: 'users#logout'
      get 'user_page', to: 'users#user_page'
      get 'personal_information', to: 'users#personal_information'
    end
  end
  resources :credit_cards, only: :new
  resources :items, only: :show
  resources :buyers, only: :index
end