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
  get 'account/kyc'
  patch 'account/add_phone'
  delete 'account/delete_phone'
  post 'account/check_code'
  post 'account/upload_passport_front_page'
  post 'account/upload_passport_back_page'
  post 'account/upload_passport_selfie'
  post 'account/upload_utility_bill'
  patch 'account/request_interview'

  get 'sale', to: 'sale#index'

  resources :email_subscriptions, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
