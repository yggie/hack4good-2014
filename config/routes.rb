Rails.application.routes.draw do
  root 'visitors#index'

  resources :photos, only: [:new, :create]

  resources :posts, only: [:create, :index]

  namespace :posts do
    get :search
  end
end
