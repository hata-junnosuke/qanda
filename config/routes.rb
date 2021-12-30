Rails.application.routes.draw do
  root to: 'questions#index'

  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  namespace :admin do
    resources :users
    resources :questions
  end

  resources :questions do
    resources :answers, only: [:create]
  end

  get 'answers/create'
end
