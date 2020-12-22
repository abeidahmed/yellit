module MemberTenancy
  extend ActiveSupport::Concern

  def check_member_tenancy_for(project)
    membership = current_user.find_project_membership(project)
    return redirect_to app_projects_path, notice: { message: "You have been removed from the team", banner: true } if membership.nil?
    redirect_to app_project_invitation_path(membership.signed_id(purpose: :project_invitation)) if current_user.project_invite_pending?(project)
  end
end