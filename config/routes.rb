Rails.application.routes.draw do
  resources :details
  resources :orders
  resources :customers
  resources :taxes
  resources :provinces
  resources :products
  resources :guntypes
  resources :qualities
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
