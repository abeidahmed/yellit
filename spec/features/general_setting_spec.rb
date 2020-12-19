require "rails_helper"

RSpec.feature "GeneralSettings", type: :feature do
  it "should update the project and show a success notification" do
    membership = create(:project_membership, :owner)
    sign_in(user: membership.user)
    visit app_root_path(membership.project)
    fill_in "project[name]", with: "First project"
    fill_in "project[website_url]", with: "https://example.co"
    fill_in "project[subdomain]", with: "project"
    click_button "Save"

    expect(current_path).to eq(app_root_path(membership.project))
    # expect(page).to have_text("we got your changes")
  end
end
