module Labels::LabelList
  extend ActiveSupport::Concern

  def project_labels
    scope_pundit_policy.sort_asc_by_name.search(params[:query])
  end

  private
  attr_reader :project

  def scope_pundit_policy
    policy_scope(project, policy_scope_class: LabelPolicy::Scope)
  end
end