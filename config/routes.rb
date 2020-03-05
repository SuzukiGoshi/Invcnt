Rails.application.routes.draw do
  config = Rails.application.config.invcnt
  
  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login"=> "sessions#new", as: :login
      resource :session, only: [ :create, :destroy]
      resources :inv_members
    end
  end
  constraints host: config[:leader][:host] do
    namespace :leader, path: config[:leader][:path] do
      root "top#index"
      get "login"=> "sessions#new", as: :login
      resource :session, only: [ :create, :destroy]
      resources :inv_members, only: [ :index, :show]
      resources :inventories
    end
  end
  constraints host: config[:member][:host] do
    namespace :member, path: config[:member][:path] do
      root "top#index"
      get "login"=> "sessions#new", as: :login
      resource :session, only: [ :create, :destroy]
      resources :inventories, only: [ :index, :show]
    end
  end
end
