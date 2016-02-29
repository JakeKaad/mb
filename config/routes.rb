Rails.application.routes.draw do
  devise_for :users
  root to: 'users#current_user_home'

  resources :companies, only: [:new, :show] do
    resources :documents, only: [:new, :create, :show, :index] do
      member do
        get :download
      end
    end

    resources :events, only: [:new, :create, :show] do
      collection do
        get :new_with_documents
        post :create_with_documents
      end
    end
  end

  resources :events do
    resources :infos, only: [:create]
  end
end
