Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'welcome#index'

  get 'exchange', to: 'welcome#exchange'
  get 'home', to: 'welcome#home'
  get 'ecosystem', to: 'welcome#ecosystem'
  get 'life', to: 'welcome#life'

  resources :email_subscriptions, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
