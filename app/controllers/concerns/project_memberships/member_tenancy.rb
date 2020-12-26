module ProjectMemberships::MemberTenancy
  extend ActiveSupport::Concern

  def check_member_tenancy
    return goodbye_team_member if membership.nil?
    redirect_to app_project_invitation_path(invitation_sid_for(membership)) if project_invite_pending?
  end

  private
  attr_reader :project

  def goodbye_team_member
    redirect_to app_projects_path, notice: { message: "You have been removed from the team", banner: true }
  end

  def membership
    current_user.find_project_membership(project)
  end

  def project_invite_pending?
    current_user.project_invite_pending?(project)
  end
end