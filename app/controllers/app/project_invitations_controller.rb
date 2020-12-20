class App::ProjectInvitationsController < App::BaseController
  layout "slate"

  def show
    @membership = ProjectMembership.find_signed!(params[:id], purpose: :project_invitation)
    authorize @membership
  end

  def update
    membership = ProjectMembership.find(params[:id])
    authorize membership, :decider?

    if membership.update(join_date: Time.zone.now)
      redirect_to root_path, success: "Yay! You're now part of the team"
    end
  end

  def destroy
    membership = ProjectMembership.find(params[:id])
    authorize membership, :decider?

    membership.destroy
    redirect_to root_path, success: "Declined for good reasons"
  end
end
