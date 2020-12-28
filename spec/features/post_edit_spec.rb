require "rails_helper"

RSpec.feature "PostEdits", type: :feature do
  it "should redirect to invitations page if user's project invite is pending" do
    membership = create(:project_membership, :pending)
    post       = create(:post, project: membership.project)
    sign_in(user: membership.user)
    visit edit_app_post_path(post)

    expect(current_path).to eq(app_project_invitation_path(invitation_sid_for(membership)))
  end
end
