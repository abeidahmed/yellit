module ProjectMemberships::Members
  extend ActiveSupport::Concern

  def project_members
    scope_pundit_policy.search(params[:query]).filter_by_role(params[:role]) unless project_invite_pending?
  end

  private
  attr_reader :project

  def project_invite_pending?
    current_user.project_invite_pending?(project)
  end

  def scope_pundit_policy
    policy_scope(project, policy_scope_class: ProjectMembershipPolicy::Scope)
  end
end