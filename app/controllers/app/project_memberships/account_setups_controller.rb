class App::ProjectMemberships::AccountSetupsController < ApplicationController
  def edit
  end

  def update
    membership = ProjectMembership::AccountSetup.new(account_setup_params.merge({ id: params[:project_membership_id] }))

    if membership.update
      login(membership.user)
    else
      render json: { errors: membership.errors }, status: :bad_request
    end
  end

  private
  def account_setup_params
    params.require(:user).permit(:full_name, :password)
  end
end
