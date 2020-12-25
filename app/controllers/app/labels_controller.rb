class App::LabelsController < App::BaseController
  def index
    @project = Project.find(params[:id])
    skip_policy_scope
  end

  def create
    project = Project.find(params[:project_id])
    authorize project, policy_class: LabelPolicy

    label = project.labels.build(label_params)
    if label.save
      # do something
    else
      render json: { errors: label.errors }, status: :bad_request
    end
  end

  private
  def label_params
    params.require(:label).permit(:name, :bg_color, :text_color)
  end
end
