Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'information/contact'

  resources :tags,       only: [ :index, :show ]
  resources :categories, only: [ :index, :show ]
  resources :photos,     only: [ :index, :show ]

  root to: 'photos#index'
  get '/' => 'photos#index'
  get 'contact' => 'information#contact'
  post 'order_update' => 'photos#order_update'
end
