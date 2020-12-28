class App::PostsController < App::BaseController
  def edit
    skip_authorization
  end
end
