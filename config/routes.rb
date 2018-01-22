Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Static_controller routes
  root 'static#home'

  # Devise routes
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

end
