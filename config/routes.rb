Rails.application.routes.draw do
  root to: "bookings#index"
  devise_for :users
  resources :cars, only: ['show']
  resources :bookings
end
