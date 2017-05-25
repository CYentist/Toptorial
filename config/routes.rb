Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users

  resources :photos
  delete 'delete_media', to: "photos#delete_media"
  delete 'delete_all', to: 'photos#delete_all'

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

  resources :answers do
    member do
      get :ask
    end
  end

  namespace :admin do
    resources :tutorials do
      member do
        post :check
        post :recheck
      end
    end
    resources :orders do
     member do
       post :cancel
       post :ship
       post :shipped
       post :return
     end
   end
  end

  namespace :account do
    resources :orders do
     member do
       post :cancel
       post :ship
       post :shipped
       post :return
     end
     collection do
       get :paid
     end
   end
    resources :users do
      member do
        get :charge
      end
    end
    resources :tutorials
    resources :photos
    resources :answers
  end

  resources :orders

  root 'tutorials#index'

end
