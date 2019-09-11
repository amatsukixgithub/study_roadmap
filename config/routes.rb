Rails.application.routes.draw do
  get '/users', to: 'users#index'
  devise_for :users
  delete '/users/:id/delete', to: 'users#delete_user', as: 'user_delete'
  get '/users/:id/show', to: 'users#show_user', as: 'user_show'
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
end
