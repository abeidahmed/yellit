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
      # do something
    else
      render json: { errors: member.errors }, status: :bad_request
    end
  end

  private
  def invite_params
    params.require(:user).permit(:email_address, :role)
  end
end
