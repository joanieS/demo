Rails.application.routes.draw do

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

  resources :photos

  root 'welcome#home'
end
