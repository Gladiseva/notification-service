Rails.application.routes.draw do
  devise_for :users

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end
