Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests
  devise_for :users
  get 'welcome/index'
  resources :notes

  authenticated :user do
    root 'notes#index', as: "authenticated_root" #notes controller, index action
  end

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
