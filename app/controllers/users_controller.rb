class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      login(user)
      redirect_to root_path
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  private
  def user_params
    params.require(:user).permit(:full_name, :email_address, :password)
  end
end
