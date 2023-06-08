Rails.application.routes.draw do
  root to: "bookings#index"
  devise_for :users
  get 'dashboard', to: 'pages#dashboard'
  resources :cars, only: ['show']
  resources :bookings
  get '', to: 'pages#dashboard'
end
