class App::ProjectInvitationsController < App::BaseController
  layout "slate"

  def show
    skip_authorization
  end

  def update
    membership = ProjectMembership.find(params[:id])
    authorize membership, :roller?

    membership.update(join_date: Time.zone.now)
  end
end
