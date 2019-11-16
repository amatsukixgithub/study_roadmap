Rails.application.routes.draw do
  # --- ユーザー関連 ---
  devise_for :users
  get '/users', to: 'users#index'
  get '/users/:id/show', to: 'users#show_user', as: 'user_show'
  delete '/users/:id/delete', to: 'users#delete_user', as: 'user_delete'
  # フォローフォロワー
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  # --- ロードマップ関連 ---
  # 一覧
  get '/roadmaps', to: 'roadmap_headers#index'
  # 詳細
  get '/roadmaps/:id/show', to: 'roadmap_headers#detail', as: 'roadmap_show'
  # 作成
  get '/roadmaps/new', to: 'roadmap_headers#new', as: 'roadmap_new'
  post '/roadmaps/new', to: 'roadmap_headers#create', as: 'roadmap_create'
  # 編集
  get '/roadmaps/:id/edit', to: 'roadmap_headers#edit', as: 'roadmap_edit'
  patch '/roadmaps/:id/edit', to: 'roadmap_headers#update', as: 'roadmap_update'
  # 削除
  delete '/roadmaps/:id/destroy', to: 'roadmap_headers#destroy', as: 'roadmap_destroy'

  # --- 静的ページ ---
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
end
