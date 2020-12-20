require "rails_helper"

RSpec.describe ProjectMailer, type: :mailer do
  describe "#project_invitation" do
    it "should send a regular email if the user is persisted" do
      membership = create(:project_membership, :pending)
      mail       = ProjectMailer.project_invitation(membership)

      expect(mail.subject).to eq("You have an invitation to #{membership.project.name}")
      expect(mail.body.encoded).to match(app_project_invitation_url(membership.signed_id(purpose: :project_invitation)))
      expect(mail.body.encoded).to_not match(/notice/)
    end

    it "should send a new user email if user is not registered" do
      membership = create(:project_membership, :pending)
      mail       = ProjectMailer.project_invitation(membership, new_user: true)

      expect(mail.subject).to eq("You have an invitation to #{membership.project.name}")
      expect(mail.body.encoded).to match(edit_app_project_membership_account_setup_url(membership.signed_id(purpose: :project_invitation)))
      expect(mail.body.encoded).to match(/notice/)
    end
  end
end
