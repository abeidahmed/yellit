require "rails_helper"

RSpec.describe "App::ProjectMemberships::AccountSetups", type: :request do
  describe "#update" do
    it "should let user update their name and password" do
      membership = create(:project_membership, :pending)
      patch app_project_membership_account_setup_path(membership.signed_id(purpose: :project_invitation)), params: { user: {
        full_name: "New full name", password: "newuserpassword"
      } }

      membership.reload
      user = membership.user
      expect(user.full_name).to eq("New full name")
      expect(user.authenticate("newuserpassword")).to be_truthy
      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

    it "should not allow anonymous as user's full name" do
      membership = create(:project_membership, :pending)
      patch app_project_membership_account_setup_path(membership.signed_id(purpose: :project_invitation)), params: { user: {
        full_name: "   Anonymous  ", password: "newuserpassword"
      } }

      expect(json.dig(:errors, :full_name)).to be_present
    end

    it "should return error if request is not valid" do
      membership = create(:project_membership, :pending)
      patch app_project_membership_account_setup_path(membership.signed_id(purpose: :project_invitation)), params: { user: { full_name: "", password: "" } }

      expect(json.dig(:errors, :full_name)).to be_present
      expect(json.dig(:errors, :password)).to be_present
    end
  end
end
