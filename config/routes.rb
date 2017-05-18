Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users

  resources :users do
    member do
      get :charge
    end
  end

  resources :tutorials do
    member do
      post :buy
      get :preview
      put "like", to: "tutorials#upvote"
      put "dislike", to: "tutorials#downvote"
    end
    collection do
      get :paid
      get :search
    end
    resources :comments
  end

  namespace :admin do
    resources :tutorials do
      member do
        post :check
        post :recheck
      end
    end
  end

  namespace :account do
    resources :users
    resources :tutorials
  end

  root 'tutorials#index'

end
