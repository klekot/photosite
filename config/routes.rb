Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'information/contact'

  resources :tags
  resources :categories
  resources :photos

  root to: 'photos#index'
  get '/' => 'photos#index'
  get 'contact' => 'information#contact'
  post 'order_update' => 'photos#order_update'
end
