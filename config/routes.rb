Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
             only: [:new, :create, :edit, :update],
             path: 'users',
             path_names: {new: 'sign_up'},
             controller: 'users/registrations',
             as: :user_registration do
      get :cancel
    end
  end

  root 'welcome#index'

  get 'exchange', to: 'welcome#exchange'
  get 'home', to: 'welcome#home'
  get 'ecosystem', to: 'welcome#ecosystem'
  get 'life', to: 'welcome#life'

  get 'account', to: 'account#index'

  resources :email_subscriptions, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
