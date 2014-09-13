Rails.application.routes.draw do
  root 'photos#new'

  resources :photos, only: [:new, :create]
end
