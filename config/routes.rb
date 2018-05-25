Rails.application.routes.draw do
  resources :user_collections
  resources :user_notes
  devise_for :users, :path_prefix => 'my'
  resources :users do
    member do
      put 'promote', to: 'users#promote'
      put 'unpromote', to: 'users#unpromote'
    end
  end
  resources :friendship
  resources :friend_requests
  resources :notes, param: :note_id do
    get 'index_share', to: 'notes#index_share'
    put 'share', to: 'notes#share'
  end
  resources :collections, param: :collection_id do
    member do
      put 'fill', to: 'collections#fill'
      put 'unfill', to: 'collections#unfill'
      get 'index_share', to: 'collections#index_share'
      put 'share', to: 'collections#share'
    end
  end

  get 'users/show'
  get 'friends/index'
  get 'friends/destroy'
  get 'welcome/index'


  authenticated :user do
    root 'notes#index', as: 'authenticated_root' #notes controller, index action
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
