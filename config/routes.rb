Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: [:index] do
    collection do
      get 'logout', to: 'users#logout'
    end
  end
  resources :credit_cards, only: [:new]
  resources :items, only: :show
  get 'buyers/index'
  get 'buyers/done'
  root 'items#index'
  resources :items do
    resources :buyers, only: [:index] do
      collection do
        get 'done', to: 'buyers#done'
        post 'pay', to: 'buyer#pay'
      end
    end
  end
end
