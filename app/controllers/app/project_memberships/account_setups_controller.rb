class App::ProjectMemberships::AccountSetupsController < ApplicationController
  def edit
    @membership = ProjectMembership.find_signed!(params[:project_membership_id], purpose: :project_invitation)
    @user       = @membership.user
  end

  def update
    membership = ProjectMembership::AccountSetup.new(account_setup_params.merge({ id: params[:project_membership_id] }))

    if membership.update
      login(membership.user)
      redirect_to app_project_invitation_path(membership.id)
    else
      render json: { errors: membership.errors }, status: :bad_request
    end
  end

  private
  def account_setup_params
    params.require(:user).permit(:full_name, :password)
  end
end
