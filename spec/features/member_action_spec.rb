require "rails_helper"

RSpec.feature "MemberActions", type: :feature do
  let(:project) { create(:project) }
  let(:membership) { create(:project_membership, :owner, project: project) }

  it "should promote the member to owner and show success notification" do
    another_membership = create(:project_membership, project: project)
    initialize_action(membership)

    expect(last_user).to have_text(another_membership.email_address)
    within last_user do
      page.all(:css, "#user-promote-btn", visible: false).first.click
    end

    expect(current_path).to eq(app_project_memberships_path(membership.project))
    expect(page).to have_text("Promoted #{another_membership.email_address} to owner")
  end

  # it "should demote the owner" do
  #   another_membership = create(:project_membership, :owner, project: project)
  #   initialize_action(membership)

  #   expect(last_user).to have_text(another_membership.email_address)
  #   within last_user do
  #     find("#user-demote-btn").click
  #   end

  #   expect(page).to have_text("Demoted #{another_membership.full_name} to member")
  # end

  # it "should remove the user" do
  #   another_membership = create(:project_membership, :owner, project: project)
  #   initialize_action(membership)

  #   expect(last_user).to have_text(another_membership.email_address)
  #   within last_user do
  #     find("#user-remove-btn").click
  #   end

  #   expect(page).to have_text("Removed #{another_membership.full_name} for good reasons")
  # end

  # it "should exit the user" do
  #   another_membership = create(:project_membership, :owner, project: project)
  #   initialize_action(membership)

  #   expect(first_user).to have_text(membership.email_address)
  #   within first_user do
  #     find("#user-exit-btn").click
  #   end

  #   expect(current_path).to eq(app_projects_path)
  #   expect(page).to have_text("Exited for good reasons")
  # end

  # it "should flash error message if there is only one owner and owner tries to exit the team" do
  #   initialize_action(membership)

  #   find("#user-exit-btn").click
  #   expect(page).to have_text("promote your colleague")
  # end

  def initialize_action(membership)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)
  end

  def last_user
    page.all(:css, "#project-member-list").last
  end

  # def first_user
  #   page.all(:css, "#project-member-list").first
  # end
end
