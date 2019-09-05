Rails.application.routes.draw do
  get '/users', to: 'users#index'
  devise_for :users
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/contact'
  get 'static_pages/about'
end
