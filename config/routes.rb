Rails.application.routes.draw do
  devise_for :users

  resources :notifications do
  end

  root 'notifications#index'

end
