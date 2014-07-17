Rails.application.routes.draw do

  devise_for :users

  # ensures user interracts with model when editing instead of devise
  resources :users, only: [:show, :index, :update, :edit]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :customers, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :installations do 
      resources :beacons, only: [:show, :new, :create, :edit, :update, :destroy]
    end
  end

  resources :audio_clips

  resources :photos

  root 'welcome#home'
end
