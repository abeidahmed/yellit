require "rails_helper"

RSpec.feature "PostLists", type: :feature do
  it "should redirect to invitations page if user's project invite is pending" do
    membership = create(:project_membership, :pending)
    sign_in(user: membership.user)
    visit app_project_path(membership.project)

    expect(current_path).to eq(app_project_invitation_path(invitation_sid_for(membership)))
  end
end
