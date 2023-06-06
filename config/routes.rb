Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users
  resources :cars, only: ['show']
  resources :bookings
end
