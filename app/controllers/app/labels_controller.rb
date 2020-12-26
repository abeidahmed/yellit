class App::LabelsController < App::BaseController
  include Labels::LabelList

  def index
    @project = Project.find(params[:id])
    skip_policy_scope

    @labels  = project_labels
  end

  def create
    project = Project.find(params[:project_id])
    authorize project, policy_class: LabelPolicy

    label = project.labels.build(label_params)
    if label.save
      redirect_back_or_to app_labels_path(project)
    else
      render json: { errors: label.errors }, status: :bad_request
    end
  end

  def update
    label = Label.find(params[:id])
    authorize label

    if label.update(label_params)
      redirect_back_or_to app_labels_path(label.project), success: { message: "OK, we got your changes" }
    else
      render json: { errors: label.errors }, status: :bad_request
    end
  end

  def destroy
    label = Label.find(params[:id])
    authorize label

    label.destroy
    redirect_back_or_to app_labels_path(label.project), success: { message: "Deleted for good reasons" }
  end

  private
  def label_params
    params.require(:label).permit(:name, :color)
  end
end
