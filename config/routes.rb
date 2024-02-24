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
end

namespace :admin do
    get 'top', to:'homes#top'
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
