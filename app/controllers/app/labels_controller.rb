class App::LabelsController < App::BaseController
  def index
    @project = Project.find(params[:id])
    @labels  = policy_scope(@project, policy_scope_class: LabelPolicy::Scope)
  end

  def create
    project = Project.find(params[:project_id])
    authorize project, policy_class: LabelPolicy

    label = project.labels.build(label_params)
    if label.save
      redirect_back fallback_location: app_labels_path(project)
    else
      render json: { errors: label.errors }, status: :bad_request
    end
  end

  def update
    label = Label.find(params[:id])
    authorize label

    if label.update(label_params)
      # do
    else
      render json: { errors: label.errors }, status: :bad_request
    end
  end

  def destroy
    label = Label.find(params[:id])
    authorize label

    label.destroy
  end

  private
  def label_params
    params.require(:label).permit(:name, :bg_color, :text_color)
  end
end
