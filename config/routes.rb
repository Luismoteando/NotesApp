Rails.application.routes.draw do
  devise_for :users, :path_prefix => 'my'
  resources :users do
    member do
      put "promote", to: "users#promote"
      put "unpromote", to: "users#unpromote"
    end
  end
  resources :friendship
  resources :friend_requests
  resources :notes, param: :note_id
  resources :collections, param: :collection_id do
    member do
      put "fill", to: "collections#fill"
      put "unfill", to: "collections#unfill"
    end
  end

  get 'users/show'
  get 'friends/index'
  get 'friends/destroy'
  get 'welcome/index'


  authenticated :user do
    root 'notes#index', as: "authenticated_root" #notes controller, index action
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
