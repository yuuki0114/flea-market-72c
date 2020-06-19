Rails.application.routes.draw do
  root 'items#index'
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
