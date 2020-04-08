Rails.application.routes.draw do

  devise_for :customers
  root "products#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :details
  resources :orders
  resources :customers
  resources :taxes
  resources :provinces
  resources :products, :only => [:index, :show]
  resources :guntypes
  resources :qualities

  get "/p/:permalink", to: "pages#permalink", as: "permalink"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
