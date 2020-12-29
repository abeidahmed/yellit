class App::Labels::SectionLabelsController < App::BaseController
  layout false

  def index
    @project = Project.find(params[:project_id])
    check_member_tenancy

    @labels = policy_scope(@project, policy_scope_class: LabelPolicy::Scope).where(id: params[:element_ids])
  end
end
