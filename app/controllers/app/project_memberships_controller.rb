class App::ProjectMembershipsController < App::BaseController
  include ProjectMemberships::Members

  def index
    @project = Project.find(params[:id])

    skip_policy_scope
    check_member_tenancy_for @project

    @memberships = project_members
  end

  def create
    project = Project.find(params[:project_id])
    authorize project, policy_class: ProjectMembershipPolicy

    member = ProjectMembership::Invitation.new(invite_params.merge({ project: project }))
    if member.invited
      redirect_to app_project_memberships_path(project)
      flash[:success] = { message: "#{member.email_address} has been invited" }
    else
      render json: { errors: member.errors }, status: :bad_request
    end
  end

  def update
    membership = ProjectMembership.find(params[:id])
    authorize membership, :roller?

    if membership.owner?
      membership.member!
      flash[:success] = { message: "Demoted #{membership.email_address} to member" }
    else
      membership.owner!
      flash[:success] = { message: "Promoted #{membership.email_address} to owner" }
    end
    redirect_back_or_to app_project_memberships_path(membership.project)
  end

  def destroy
    membership = ProjectMembership.find(params[:id])
    authorize membership

    owner = ProjectMembership::Tombstone.new(membership: membership, current_user: current_user)
    if owner.needs_partner_owner?
      redirect_back_or_to app_project_memberships_path(membership.project)
      flash[:alert] = { message: "Please promote your colleague to owner before you leave", banner: true }
      return
    end

    membership.destroy
    if current_user == membership.user
      redirect_to app_projects_path, success: { message: "Exited for good reasons" }
    else
      flash[:success] = { message: "Removed #{membership.email_address} for good reasons" }
      redirect_back_or_to app_project_memberships_path(membership.project)
    end
  end

  private
  def invite_params
    params.require(:user).permit(:email_address, :role)
  end
end
