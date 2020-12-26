require "rails_helper"

RSpec.feature "LabelActions", type: :feature do
  it "should delete the label" do
    membership = create(:project_membership)
    project    = membership.project
    label      = create(:label, project: project)
    sign_in(user: membership.user)
    visit app_labels_path(project)
    within "#label-list", visible: false do
      page.all(:css, ".label-delete-btn", visible: false).first.click
    end

    expect(current_path).to eq(app_labels_path(project))
    expect(page).to have_text("for good reasons")
  end
end
