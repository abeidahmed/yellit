Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create)
  root "static_pages#home"

  namespace :app do
    resources :projects, only: %i(index show update) do
      resources :project_memberships, only: %i(create)
    end

    resources :project_invitations, only: %i(show update destroy)

    resources :project_memberships, only: %i(update destroy) do
      resource :account_setup, only: %i(edit update), module: :project_memberships
    end

    scope "/settings/:id" do
      root "projects#edit"
      resource :public_feeds, only: %i(edit)
      resources :project_memberships, only: %i(index)
    end
  end
end
