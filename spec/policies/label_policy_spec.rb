require "rails_helper"

RSpec.describe LabelPolicy, type: :policy do
  let(:membership) { create(:project_membership) }
  let(:user) { membership.user }
  let(:project) { membership.project }

  subject { described_class.new(user, project) }

  include_examples "being_a_visitor"

  context "being an owner" do
    let(:membership) { create(:project_membership, :owner) }

    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a member" do
    it { is_expected.to permit_actions(%i(create)) }
  end

  context "being a spectator" do
    let(:membership) { create(:project_membership, :pending_owner) }

    it { is_expected.to forbid_actions(%i(create)) }
  end
end
