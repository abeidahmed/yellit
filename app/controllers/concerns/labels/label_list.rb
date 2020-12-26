module Labels::LabelList
  extend ActiveSupport::Concern

  def project_labels
    check_member_tenancy
    scope_pundit_policy.sort_asc_by_name.search(params[:query]) unless project_invite_pending?
  end

  private
  attr_reader :project

  def project_invite_pending?
    current_user.project_invite_pending?(project)
  end

  def scope_pundit_policy
    policy_scope(project, policy_scope_class: LabelPolicy::Scope)
  end
end