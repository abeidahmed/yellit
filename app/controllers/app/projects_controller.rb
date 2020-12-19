class App::ProjectsController < App::BaseController
  def edit
    skip_authorization
  end

  def update
    project = Project.find(params[:id])
    authorize project

    if project.update(project_params)
      # do something
    else
      render json: { errors: project.errors }, status: :bad_request
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :website_url, :subdomain)
  end
end
