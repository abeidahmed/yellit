Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create)
  root "static_pages#home"

  namespace :app do
    resources :projects, only: %i(index show update) do
      resources :project_memberships, only: %i(create)
      resources :labels, only: %i(create)
      resources :posts, only: %i(new)

      # renders without layout
      resources :filter_memberships, only: %i(index), module: :project_memberships
      resources :filter_labels, only: %i(index), module: :labels
      resources :section_labels, only: %i(index), module: :labels
      resources :section_filter_labels, only: %i(index), module: :labels
    end

    resources :project_invitations, only: %i(show update destroy)
    resources :labels, only: %i(update destroy)
    resources :posts, only: %i(edit update)

    resources :project_memberships, only: %i(update destroy) do
      resource :account_setup, only: %i(edit update), module: :project_memberships
    end

    scope "/settings/:id" do
      root "projects#edit"
      resource :public_feeds, only: %i(edit)
      resources :project_memberships, only: %i(index)
      resources :labels, only: %i(index)
    end
  end
end
