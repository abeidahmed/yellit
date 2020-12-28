class App::PostsController < App::BaseController
  def new
    project = Project.find(params[:project_id])
    authorize project, policy_class: PostPolicy

    post = project.posts.create! title: "Untitled", draft: 1
    redirect_to edit_app_post_path(post)
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post, policy_class: PostPolicy

    @project = @post.project
    check_member_tenancy

    @post.sections.build if @post.sections.blank?
  end

  def update
    post = Post.find(params[:id])
    authorize post

    if post.update(post_params)
      redirect_back_or_to edit_app_post_path(post), success: { message: "OK, we got your changes" }
    else
      render json: { errors: post.errors }, status: :bad_request
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :draft, :published_at, sections_attributes: [:id, :body, :_destroy])
  end
end
