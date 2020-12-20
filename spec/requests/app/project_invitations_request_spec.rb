require "rails_helper"

RSpec.describe "App::ProjectInvitations", type: :request do
  describe "#update" do
    it "should accept the invitation" do
      membership = create(:project_membership, :pending)
      login(membership.user)
      patch app_project_invitation_path(membership), params: nil

      expect(membership.reload.join_date).to be_present
    end
  end
end
