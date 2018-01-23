Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Static controller
  root 'static#home'

  # Devise
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Users controller
  get '/users', to: 'users#index', as: :users
  get '/users/:id/transactions', to: 'users#transactions', as: :user_transactions

  # Transactions controller
  post '/transactions/:sender_id/:receiver_id', to: 'transactions#create', as: :transactions

end
