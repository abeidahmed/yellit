require "rails_helper"

RSpec.feature "LabelForms", type: :feature do
  it "should create the tag and list the tag" do
    membership = create(:project_membership)
    project    = membership.project
    sign_in(user: membership.user)
    visit app_labels_path(project)
    within "#label-form" do
      fill_in "Label name", with: "Just created"
      fill_in "Color", with: "#000000"
      click_button "Create"
    end

    expect(current_path).to eq(app_labels_path(project))
  end
end
