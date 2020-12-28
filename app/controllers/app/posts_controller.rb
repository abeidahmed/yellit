class App::PostsController < App::BaseController
  def new
  end

  def edit
    skip_authorization
  end
end
