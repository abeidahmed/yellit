require "rails_helper"

RSpec.feature "MemberLists", type: :feature do
  it "should redirect to invitations page if user's project invite is pending" do
    membership = create(:project_membership, :pending)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)

    expect(current_path).to eq(app_project_invitation_path(membership.signed_id(purpose: :project_invitation)))
  end

  it "should list all the members of the team" do
    project    = create(:project)
    user       = create(:user, full_name: "Not to be found")
    membership = create(:project_membership, project: project)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)

    expect(page).to have_text(membership.full_name)
    expect(page).not_to have_text(user.full_name)
  end
end
