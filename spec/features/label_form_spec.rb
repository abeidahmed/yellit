require "rails_helper"

RSpec.feature "LabelForms", type: :feature do
  it "should create the label and list the tag" do
    membership = create(:project_membership)
    project    = membership.project
    sign_in(user: membership.user)
    visit app_labels_path(project)
    within ".label-form", visible: false do
      fill_in "Label name", visible: false, with: "Just created"
      fill_in "Color", visible: false, with: "#000000"
      click_button "Create", visible: false
    end

    expect(current_path).to eq(app_labels_path(project))
  end

  it "should update the label and show success notification" do
    membership = create(:project_membership)
    project    = membership.project
    label      = create(:label, name: "To be updated", project: project)
    sign_in(user: membership.user)
    visit app_labels_path(project)

    update_form = page.all(:css, ".label-form", visible: false).last
    within update_form do
      fill_in "Label name", visible: false, with: "Updated label"
      fill_in "Color", visible: false, with: "#ffffff"
      click_button "Save changes", visible: false
    end

    expect(page).to have_text("got your changes")
    expect(page).to have_text("Updated label")
  end
end
