Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }


  namespace :public do
      get 'top', to:'homes#top'
      get '/customers/my_page', to: 'customers#show'
  end

  namespace :admin do
      get 'top', to:'homes#top'
      resources :customers, only: [:index, :show, :edit, :update]
      resources :genres, only: [:index, :create, :edit, :update]
      resources :items, only: [:new, :index, :show, :create, :edit, :update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
