Rails.application.routes.draw do

  devise_for :users

  # ensures user interracts with model when editing instead of devise
  resources :users, only: [:show, :edit]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # next beacons inside installations to gain access to installation_id in params
  resources :customers do
    resources :installations do 
      resources :beacons
    end
  end

  resources :audio_clips

  resources :photos

  root 'welcome#home'
end
