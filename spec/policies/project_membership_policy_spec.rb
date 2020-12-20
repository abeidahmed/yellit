require "rails_helper"

RSpec.describe ProjectMembershipPolicy, type: :policy do
  let(:project_membership) { create(:project_membership) }
  let(:user) { project_membership.user }
  let(:project) { project_membership.project }

  subject { described_class.new(user, project) }

  include_examples "being_a_visitor"

  context "being an owner" do
    let(:project_membership) { create(:project_membership, :owner) }

    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a member" do
    it { is_expected.to forbid_actions(%i(create)) }
  end

  context "being a pending user" do
    let(:project_membership) { create(:project_membership, :pending_owner) }

    it { is_expected.to forbid_actions(%i(create)) }
  end
end
