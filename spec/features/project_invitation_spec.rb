require "rails_helper"

RSpec.feature "ProjectInvitations", type: :feature do
  it "should sent an invite and display a success toast" do
    user = create(:user)
    membership = create(:project_membership, :owner)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)
    within "#member-invite-form", visible: false do
      fill_in "user_email_address", visible: false, with: user.email_address
      select "Owner", visible: false
      click_button "invitation", visible: false
    end

    expect(current_path).to eq(app_project_memberships_path(membership.project))
    expect(page).to have_text("invited")
  end

  it "should accept the invitation when accept invite button is clicked" do
    membership = create(:project_membership, :pending)
    sign_in(user: membership.user)
    visit app_project_invitation_path(invitation_sid_for(membership))
    click_button "Accept"

    expect(current_path).to eq(app_project_path(membership.project))
    expect(page).to have_text("part of the team")
  end

  it "should decline the invitation when decline invite button is clicked" do
    membership = create(:project_membership, :pending)
    sign_in(user: membership.user)
    visit app_project_invitation_path(invitation_sid_for(membership))
    click_button "Decline"

    expect(current_path).to eq(app_projects_path)
    expect(page).to have_text("Declined for good reasons")
  end

  it "should take me to app_projects_path if I click on the later link" do
    membership = create(:project_membership, :pending)
    sign_in(user: membership.user)
    visit app_project_invitation_path(invitation_sid_for(membership))
    click_link "later"

    expect(current_path).to eq(app_projects_path)
  end
end
