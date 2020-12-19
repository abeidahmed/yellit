Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create)
  root "static_pages#home"

  namespace :app do
    scope "/settings/:id" do
      root "projects#edit"
    end
  end
end
