require "rails_helper"

RSpec.feature "LabelLists", type: :feature do
  it "should redirect to invitations page if user's project invite is pending" do
    membership = create(:project_membership, :pending)
    sign_in(user: membership.user)
    visit app_labels_path(membership.project)

    expect(current_path).to eq(app_project_invitation_path(invitation_sid_for(membership)))
  end

  it "should list all the labels of the current project" do
    project       = create(:project)
    membership    = create(:project_membership, project: project)
    label         = create(:label, project: project, name: "To be found")
    another_label = create(:label, name: "Not to be found")
    sign_in(user: membership.user)
    visit app_labels_path(project)

    expect(page).to have_text(label.name)
    expect(page).to_not have_text(another_label.name)
  end
end
