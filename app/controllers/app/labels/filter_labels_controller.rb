class App::Labels::FilterLabelsController < App::BaseController
  layout false

  def index
    @project = Project.find(params[:project_id])
    @labels  = policy_scope(@project, policy_scope_class: LabelPolicy::Scope).sort_asc_by_name.search(params[:query])
  end
end
