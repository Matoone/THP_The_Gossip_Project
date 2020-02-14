Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'gossips#index'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  get '/welcome/:first_name', to: 'welcome#user', as: 'welcome'
  resources :gossips
  resources :users, only: [:show, :new, :create]
  resources :cities, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :comments, only: [:new, :create, :destroy, :edit, :update]
  resources :likes, only: [:new, :create, :destroy]
end
