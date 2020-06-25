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
  resources :users, only: [:index, :edit] do
    collection do
      get 'logout', to: 'users#logout'
      get 'user_page', to: 'users#user_page'
      get 'personal_information', to: 'users#personal_information'
    end
  end
  resources :credit_cards, only: [:index, :new, :create, :destory, :show] do
    member do
      post 'pay'
    end
  end
  resources :items, only: [:show, :new]
  resources :buyers, only: :index
  resources :profiles, only: :new
  resources :addresses, only: :new
end
