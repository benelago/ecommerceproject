Rails.application.routes.draw do

  devise_for :customers

  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  get 'search', to: 'products#search', as: 'search'

  root "products#index"

  scope 'checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout)cancel'
  end


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
