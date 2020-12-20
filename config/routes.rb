Rails.application.routes.draw do
  resources :users, only: %i(new create)
  resources :sessions, only: %i(new create)
  root "static_pages#home"

  namespace :app do
    resources :projects, only: %i(update)
    resources :project_invitations, only: %i(show)

    scope "/settings/:id" do
      root "projects#edit"
      resource :public_feeds, only: %i(edit)
      resources :project_memberships, only: %i(index)
    end
  end
end
