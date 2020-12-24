class App::ProjectMemberships::FilterMembershipsController < App::BaseController
  layout false

  def index
    @project = Project.find(params[:project_id])

    skip_policy_scope
    check_member_tenancy_for @project

    unless current_user.project_invite_pending?(@project)
      @memberships = policy_scope(@project, policy_scope_class: ProjectMembershipPolicy::Scope).
        search(params[:query]).
        filter_by_role(params[:role])
    end
  end
end
