Rails.application.routes.draw do
  get '/users', to: 'users#index'
  devise_for :users
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/about', to: 'static_pages#about'
end
