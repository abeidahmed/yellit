class App::ProjectsController < App::BaseController
  def index
    skip_policy_scope
    render layout: "slate"
  end

  def edit
    @project = Project.find(params[:id])
    authorize @project
    check_member_tenancy_for @project
  end

  def show
    @project = Project.find(params[:id])
    skip_authorization
  end

  def update
    project = Project.find(params[:id])
    authorize project

    if project.update(project_params)
      redirect_back fallback_location: app_root_path(project), success: { message: "OK, we got your changes" }
    else
      render json: { errors: project.errors }, status: :bad_request
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :website_url, :subdomain)
  end
end
