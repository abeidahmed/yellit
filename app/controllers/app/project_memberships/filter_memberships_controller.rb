class App::ProjectMemberships::FilterMembershipsController < App::BaseController
  layout false

  def index
    @project     = Project.find(params[:project_id])
    @memberships = policy_scope(@project, policy_scope_class: ProjectMembershipPolicy::Scope).
      search(params[:query])

    check_member_tenancy_for @project
  end
end
