Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  root to: "public/homes#top"
  get '/about', to: 'public/homes#about', as: 'about'

  namespace :public do
      get '/customers/my_page', to: 'customers#show'
      get '/customers/information/edit', to: 'customers#edit'
      patch '/customers/information', to: 'customers#update'
      get '/customers/unsubscribe', to: 'customers#unsubscribe'
      patch '/customers/withdraw', to: 'customers#withdraw'
      get '/orders/confirm', to: 'orders#confirm'
      get '/orders/complete', to: 'orders#complete'
      delete 'cart_items/destroy_all', to: 'cart_items#destroy_all', as: 'destroy_all_cart_items'
      resources :items, only: [:index, :show]
      resources :addresses, only: [:index, :create, :edit, :update, :destroy]
      resources :cart_items, only: [:index, :create, :update, :destroy]
      resources :orders, only: [:index, :show, :create, :new]
  end

  namespace :admin do
      root to: "homes#top"
      resources :customers, only: [:index, :show, :edit, :update]
      resources :genres, only: [:index, :create, :edit, :update]
      resources :items, only: [:new, :index, :show, :create, :edit, :update]
      resources :orders, only: [:show, :update]
      resources :order_details, only: [:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
