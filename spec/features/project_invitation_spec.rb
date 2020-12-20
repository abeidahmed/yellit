require "rails_helper"

RSpec.feature "ProjectInvitations", type: :feature do
  # it "should sent an invite and display a success toast" do
  #   user = create(:user)
  #   membership = create(:project_membership, :owner)
  #   sign_in(user: membership.user)
  #   visit app_project_memberships_path(membership.project)
  #   find("#member-invite-form", visible: false).set("hidden", {})
  #   fill_in "user[email_address]", with: user.email_address
  #   select "Owner"
  #   click_button "invitation"

  #   expect(current_path).to eq(app_project_memberships_path(membership.project))
  #   expect(page).to have_text("invited")
  # end
end
