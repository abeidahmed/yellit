class App::Labels::FilterLabelsController < App::BaseController
  layout false

  include Labels::LabelList

  def index
    @project = Project.find(params[:project_id])
    @labels  = project_labels
  end
end
