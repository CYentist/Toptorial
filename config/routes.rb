Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :tutorials

  namespace :admin do
    resources :tutorials do
      member do
        post :check
        post :recheck
      end
    end
  end

  root 'tutorials#index'

end
