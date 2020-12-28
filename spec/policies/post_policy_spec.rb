require "rails_helper"

RSpec.describe PostPolicy, type: :policy do
  let(:membership) { create(:project_membership) }
  let(:user) { membership.user }
  let(:project) { membership.project }

  subject { described_class.new(user, project) }

  include_examples "being_a_visitor"

  context "being an owner" do
    let(:membership) { create(:project_membership, :owner) }

    it { is_expected.to permit_actions(%i(new edit update)) }
  end

  context "being a permanent member" do
    it { is_expected.to permit_actions(%i(new edit update)) }
  end

  context "being a pending member" do
    let(:membership) { create(:project_membership, :pending_owner) }

    it { is_expected.to forbid_actions(%i(new edit update)) }
  end
end
