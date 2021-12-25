Rails.application.routes.draw do

  get 'answers/create'
  resources :users
  post '/users', to: 'users#create'
  delete '/users', to: 'users#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  namespace :admin do
    resources :users
    resources :questions
  end

  root to: 'questions#index'
  resources :questions do
    resources :answers, only: [:create]
  end
  get "/question/solved", to: "questions#solved"
  get "/question/unsolved", to: "questions#unsolved"

end
