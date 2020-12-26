class App::ProjectMemberships::FilterMembershipsController < App::BaseController
  layout false

  include ProjectMemberships::MemberList

  def index
    @project = Project.find(params[:project_id])
    skip_policy_scope

    @memberships = project_members
  end
end
