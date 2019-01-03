# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/create'
  root 'home#index'
  resources :home
  resources :posts do
    member do
      put 'like', to: 'posts#like'
      put 'unlike', to: 'posts#unlike'
    end
    resources :comments, only: %i[create destroy]
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_oa_session
  end
end
