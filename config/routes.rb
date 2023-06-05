Rails.application.routes.draw do
  root to: "pages#home"
  resources :cars, only: %i[show] do
    resources :bookings
  end
end
