Rails.application.routes.draw do
  resources :users, only: %i(new)
  root "static_pages#home"
end
