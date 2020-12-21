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

  it "should restrict all options if user is member only" do
    project            = create(:project)
    membership         = create(:project_membership, project: project)
    another_membership = create(:project_membership, project: project)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)

    expect(last_user).to have_text(another_membership.email_address)
    restrict_all_options
  end

  it "should only see promote and remove option if current user is owner and other user is member" do
    project            = create(:project)
    membership         = create(:project_membership, :owner, project: project)
    another_membership = create(:project_membership, project: project)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)

    expect(last_user).to have_text(another_membership.email_address)
    expect(last_user).not_to have_text("Demote")
    expect(last_user).to have_text("Promote")
    expect(last_user).to have_text("Remove")
  end

  it "should only see exit option if current user is the user" do
    project    = create(:project)
    membership = create(:project_membership, :owner, project: project)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)

    expect(last_user).to have_text("Exit")
    restrict_all_options
  end

  it "should only see demote and remove option if other user is an owner too" do
    project            = create(:project)
    membership         = create(:project_membership, :owner, project: project)
    another_membership = create(:project_membership, :owner, project: project)
    sign_in(user: membership.user)
    visit app_project_memberships_path(membership.project)

    expect(last_user).to have_text(another_membership.email_address)
    expect(last_user).to have_text("Demote")
    expect(last_user).to have_text("Remove")
    expect(last_user).not_to have_text("Promote")
  end

  def last_user
    page.all(:css, "#project-member-list").last
  end

  def restrict_all_options
    expect(last_user).not_to have_text("Promote")
    expect(last_user).not_to have_text("Demote")
    expect(last_user).not_to have_text("Remove")
  end
end
