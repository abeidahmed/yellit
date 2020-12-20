class App::ProjectMembershipsController < App::BaseController
  def index
    @project     = Project.find(params[:id])
    @memberships = policy_scope(@project, policy_scope_class: ProjectMembershipPolicy::Scope)
    check_member_tenancy_for @project
  end
end
