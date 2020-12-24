class App::ProjectMemberships::FilterMembershipsController < App::BaseController
  layout false

  include ProjectMemberships::Members

  def index
    @project = Project.find(params[:project_id])

    skip_policy_scope
    check_member_tenancy_for @project

    @memberships = project_members
  end
end
