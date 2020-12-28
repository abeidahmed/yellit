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

  def update
    post = Post.find(params[:id])
    authorize post

    if post.update(post_params)
      # do something
    else
      render json: { errors: post.errors }, status: :bad_request
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :draft, :published_at, sections_attributes: [:id, :body])
  end
end
