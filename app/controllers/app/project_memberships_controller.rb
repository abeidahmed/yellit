class App::ProjectMembershipsController < App::BaseController
  def index
    @project     = Project.find(params[:id])
    @memberships = policy_scope(@project, policy_scope_class: ProjectMembershipPolicy::Scope)
    check_member_tenancy_for @project
  end

  def create
    project = Project.find(params[:project_id])
    authorize project, policy_class: ProjectMembershipPolicy

    member = ProjectMembership::Invitation.new(invite_params.merge({ project: project }))
    if member.invited
      redirect_to app_project_memberships_path(project)
      flash[:success] = "#{member.email_address} has been invited"
    else
      render json: { errors: member.errors }, status: :bad_request
    end
  end

  def update
    membership = ProjectMembership.find(params[:id])
    authorize membership, :roller?

    if membership.owner?
      membership.member!
      flash[:success] = "Demoted #{membership.email_address} to member"
    else
      membership.owner!
      flash[:success] = "Promoted #{membership.email_address} to owner"
    end
    redirect_back fallback_location: app_project_memberships_path(membership.project)
  end

  def destroy
    membership = ProjectMembership.find(params[:id])
    authorize membership

    owner = ProjectMembership::Tombstone.new(membership: membership, current_user: current_user)
    if owner.needs_partner_owner?
      redirect_back fallback_location: app_project_memberships_path(membership.project)
      flash[:alert] = "Please promote your colleague to owner before you leave"
      return
    end

    membership.destroy
    if current_user == membership.user
      redirect_to app_projects_path, success: "Exited for good reasons"
    else
      flash[:success] = "Removed #{membership.email_address} for good reasons"
      redirect_back fallback_location: app_project_memberships_path(membership.project)
    end
  end

  private
  def invite_params
    params.require(:user).permit(:email_address, :role)
  end
end
