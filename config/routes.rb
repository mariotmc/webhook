Rails.application.routes.draw do
  namespace :webhook do
    resources :subscriptions, only: [:create, :index]
    resources :endpoints, only: [:index, :create]
  end
end
