Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      devise_for :users

      # Ensures user interracts with model as opposed to devise when editing.
      resources :users, only: [:index, :update, :edit, :destroy]
      #ActiveAdmin::Devise.config
      #ActiveAdmin.routes(self)

      resources :customers, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
        resources :installations do 
          resources :beacons, only: [:show, :new, :create, :edit, :update, :destroy] do
            resources :audio_clips
          end
        end
      end

      get "/location/:latitude/:longitude", :to => "customers#index"

      # get "/metrics", :to => 'welcome#metrics'

      # get "/metrics/:beacon_id", :to

      resources :photos

      root :to => 'welcome#home'
    end
  end


  devise_for :users

  # Ensures user interracts with model as opposed to devise when editing.
  resources :users, only: [:index, :update, :edit, :destroy]
  #ActiveAdmin::Devise.config
  #ActiveAdmin.routes(self)

  resources :customers, only: [:show, :index, :new, :create, :edit, :update, :destroy] do
    resources :installations do 
      resources :beacons, only: [:show, :new, :create, :edit, :update, :destroy] do
        resources :audio_clips
      end
    end
  end

  get "/location/:latitude/:longitude", :to => "customers#index"

  # get "/metrics", :to => 'welcome#metrics'

  # get "/metrics/:beacon_id", :to

  resources :photos

  root :to => 'welcome#home'
end
