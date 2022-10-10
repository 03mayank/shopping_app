Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  resources :users do
    resources :addresses
  end

  resources :categories
  resources :products do
    resources :cart_items, :except => [:index]
  end

  get 'cart_items', to: 'cart_items#index', as: :cart_items

  resources :orders
  resources :order_items

  post 'orders/buy_now', to: 'orders#buy_now', as: :buy_now

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

