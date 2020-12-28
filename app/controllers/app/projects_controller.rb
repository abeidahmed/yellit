class App::ProjectsController < App::BaseController
  def index
    skip_policy_scope
    render layout: "slate"
  end

  def show
    @project = Project.find(params[:id])
    authorize @project
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
    check_member_tenancy
  end

  def update
    project = Project.find(params[:id])
    authorize project

    if project.update(project_params)
      redirect_back_or_to app_root_path(project), success: { message: "OK, we got your changes" }
    else
      render json: { errors: project.errors }, status: :bad_request
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :website_url, :subdomain)
  end
end
