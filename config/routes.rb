Rails.application.routes.draw do
  devise_for :customers
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

  resources :events, only: [] do
    resources :infos, only: [:create, :edit, :update]
    resources :customers, only: [:new, :create]
    resources :menus, only: [:create]
  end

  resources :infos, only: [] do
    resources :notes, only: [:create, :edit, :update]
  end

  resources :customers, only: [] do
    resources :contact_cards, only: [:new, :create, :edit, :update]
    resources :notes, only: [:new, :create, :edit, :update]
  end

  resources :menus, only: [] do
    resources :menu_items, only: [:create, :destroy]
  end

  resources :notes, only: [:destroy]
end
