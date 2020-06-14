Rails.application.routes.draw do
  root 'items#index'
  get 'item', to: 'items#show'
end
