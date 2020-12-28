class App::PostsController < App::BaseController
  def new
    project = Project.find(params[:project_id])
    authorize project, policy_class: PostPolicy

    post = project.posts.create! title: "Untitled", draft: 1
    redirect_to edit_app_post_path(post)
  end

  def edit
    skip_authorization
  end
end
