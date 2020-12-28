require "rails_helper"

RSpec.feature "PostNews", type: :feature do
  it "should create a new post and redirect to post edit page" do
    membership = create(:project_membership)
    project    = membership.project
    sign_in(user: membership.user)
    visit new_app_project_post_path(project)

    post = project.posts.first
    expect(post.title).to eq("Untitled")
    expect(post.published_at).to be_nil
    expect(current_path).to eq(edit_app_post_path(post))
  end
end
