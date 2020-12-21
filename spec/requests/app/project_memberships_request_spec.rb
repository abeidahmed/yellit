require "rails_helper"

RSpec.describe "App::ProjectMemberships", type: :request do
  describe "#create" do
    it "should add the user to the project team" do
      user       = create(:user)
      membership = create(:project_membership, :owner)
      project    = membership.project

      login(membership.user)
      post app_project_project_memberships_path(project), params: { user: { email_address: user.email_address, role: "member" } }

      last_membership = project.project_memberships.unscoped.last
      expect(last_membership.email_address).to eq(user.email_address)
      expect(last_membership.join_date).to be_nil
      expect(last_membership.role).to eq("member")

      expect(last_email.subject).to eq("You have an invitation to #{project.name}")
      expect(last_email.encoded).to_not match(/noticed/)
    end

    it "should create the user and add to team if user is not a member of yellit" do
      membership = create(:project_membership, :owner)
      project    = membership.project

      login(membership.user)
      post app_project_project_memberships_path(project), params: { user: { email_address: "notmember@example.com", role: "owner" } }

      expect(User.last.email_address).to eq("notmember@example.com")

      last_membership = project.project_memberships.unscoped.last
      expect(last_membership.email_address).to eq("notmember@example.com")
      expect(last_membership.full_name).to eq("Anonymous")
      expect(last_membership.join_date).to be_nil
      expect(last_membership.role).to eq("owner")

      expect(last_email.encoded).to match(/noticed/)
    end

    it "should throw error when fields is invalid" do
      user       = create(:user)
      membership = create(:project_membership, :owner)
      project    = membership.project

      login(membership.user)
      post app_project_project_memberships_path(project), params: { user: { email_address: "hello", role: "member" } }

      expect(json.dig(:errors, :email_address)).to be_present
    end

    it "should throw error when user is already on the team" do
      membership = create(:project_membership, :owner)
      project    = membership.project

      login(membership.user)
      post app_project_project_memberships_path(project), params: { user: { email_address: membership.email_address, role: "member" } }

      expect(json.dig(:errors, :email_address)).to be_present
    end
  end

  describe "#update" do
    let(:project) { create(:project) }
    let(:membership) { create(:project_membership, :owner, project: project) }

    it "should promote the member to owner" do
      another_membership = create(:project_membership, project: project)
      setup_roller_for(another_membership)

      expect(another_membership.reload.role).to eq("owner")
    end

    it "should demote the owner to member" do
      another_membership = create(:project_membership, :owner, project: project)
      setup_roller_for(another_membership)

      expect(another_membership.reload.role).to eq("member")
    end

    def setup_roller_for(user)
      login(membership.user)
      patch app_project_membership_path(user), params: nil
    end
  end
end
