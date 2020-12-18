class SessionsController < ApplicationController
  def new
  end

  def create
    auth = Authentication.new(params)

    if auth.authenticated?
      login(auth.user)
      redirect_to root_path
    else
      render json: { errors: { invalid: ["credentials"] } }, status: :bad_request
    end
  end
end
