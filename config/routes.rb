Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :cars, only: %i[show] do
    resources :bookings
  end
end
