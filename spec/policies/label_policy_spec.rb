require "rails_helper"

RSpec.describe LabelPolicy, type: :policy do
  describe "subject is project" do
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

  describe "subject is label" do
    let(:project) { create(:project) }
    let(:membership) { create(:project_membership, project: project) }
    let(:user) { membership.user }
    let(:label) { create(:label, project: project) }

    subject { described_class.new(user, label) }

    include_examples "being_a_visitor"

    context "being an owner" do
      let(:membership) { create(:project_membership, :owner, project: project) }

      it { is_expected.to permit_actions(%i(update destroy)) }
    end

    context "being a member" do
      it { is_expected.to permit_actions(%i(update destroy)) }
    end

    context "being a spectator" do
      let(:membership) { create(:project_membership, :pending_owner, project: project) }

      it { is_expected.to forbid_actions(%i(update destroy)) }
    end
  end
end
