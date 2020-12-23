class App::LabelsController < App::BaseController
  def index
    @project = Project.find(params[:id])
    skip_policy_scope
  end
end
