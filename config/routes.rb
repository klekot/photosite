Rails.application.routes.draw do
  devise_for :admins
  resources :tags
  resources :categories
  resources :photos

  root to: 'photos#index'
  get '/' => 'photos#index'
end
