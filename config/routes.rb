Rails.application.routes.draw do
  devise_for :users
  root to: 'users#current_user_home'

  resources :companies, only: [:new, :show] do
    resources :documents, only: [:new, :create]
  end
end
