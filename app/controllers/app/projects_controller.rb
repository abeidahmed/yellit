class App::ProjectsController < App::BaseController
  def edit
    skip_authorization
  end
end
