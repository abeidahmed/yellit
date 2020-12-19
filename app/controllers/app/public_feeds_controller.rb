class App::PublicFeedsController < App::BaseController
  def edit
    @project = Project.find(params[:id])
    skip_authorization
  end
end
