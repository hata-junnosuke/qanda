Rails.application.routes.draw do
  resources :users
  post '/users', to: 'users#create'
  delete '/users', to: 'users#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end

  root to: 'questions#index'
  resources :questions
end
