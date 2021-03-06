require "rails_helper"

RSpec.feature "MembershipAccountSetups", type: :feature do
  it "should redirect to project invitations path after successfully udpating the account" do
    membership = create(:project_membership, :pending)
    visit edit_app_project_membership_account_setup_path(invitation_sid_for(membership))
    fill_in "user[full_name]", with: "John Doe"
    fill_in "user[password]", with: "secretpassword"
    click_button "Save changes"

    expect(current_path).to eq(app_project_invitation_path(invitation_sid_for(membership)))
  end
end
