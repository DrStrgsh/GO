Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  	devise_scope :user do
  		delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_oa_session
	end
end
