Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users, only: [:index, :show]
  resources :organizations do
    get 'add_user', to: 'organizations#add_user'
    get 'remove_user', to: 'organizations#remove_user'
    get 'users_list', to: 'organizations#users_list'
  end
  # get '/users', to: 'users#index'
  # get '/users/show/:id', to: 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'organizations#index'
end
