require "rails_helper"

RSpec.describe ProjectPolicy, type: :policy do
  let(:membership) { create(:project_membership) }
  let(:project) { membership.project }
  let(:user) { membership.user }

  subject { described_class.new(user, project) }

  include_examples "being_a_visitor"

  context "being an owner" do
    let(:membership) { create(:project_membership, :owner) }

    it { is_expected.to permit_actions(%i(show edit update)) }
  end

  context "being a member" do
    it { is_expected.to permit_actions(%i(show edit)) }
    it { is_expected.to forbid_actions(%i(update)) }
  end

  context "being a pending user" do
    let(:membership) { create(:project_membership, :pending_owner) }

    it { is_expected.to permit_actions(%i(show edit)) }
    it { is_expected.to forbid_actions(%i(update)) }
  end
end
