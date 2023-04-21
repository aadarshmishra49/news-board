Rails.application.routes.draw do
  

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
 
  get 'messages/mymessages'
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  
  namespace :api do
    resources :messages
  end
  namespace :api do
    resources :comments
  end

namespace :api do
  namespace :v1 do
      resources :messages do
        collection do
          get 'search'
        end
      end
  end
end


namespace :api do
      resources :messages do
        collection do
          get 'search'
        end
    end
end

  namespace :api do
    namespace :v1 do
      resources :reactions
    end
  end
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
  namespace :api do
  namespace :v1 do
    resources :comments
    end
  end

  namespace :api do
    namespace :v1 do
      resources :messages
    end
  end
  devise_for :authors
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :messages do
     resources :comments
  end
  resources :users
  resources :authors
  resources :categories
  resources :reactions, only: [:create, :destroy]

  root 'messages#index'
end
