Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  devise_scope :user do
    get "profiles", to: "users/registrations#new_profile"
    post "profiles", to: "users/registrations#create_profile"
    get "addresses", to: "users/registrations#new_address"
    post "addresses", to: "users/registrations#create_address"
  end
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