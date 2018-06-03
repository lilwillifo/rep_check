Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/auth/twitter', as: :twitter_login

  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', as: :logout, to: 'sessions#destroy'

  resources :users, only: [:update] do
    resources :favorites, only: [:create]
  end

  resources :favorites, only: [:index]

  resources :representatives, only: [:create, :show, :update, :index]
end
