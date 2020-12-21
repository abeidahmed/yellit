require "rails_helper"

RSpec.describe ProjectMembershipPolicy, type: :policy do
  describe "subject is project" do
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

  describe "subject is membership" do
    let(:membership) { create(:project_membership) }
    let(:user) { membership.user }

    subject { described_class.new(user, membership) }

    include_examples "being_a_visitor"

    context "being an owner" do
      let(:membership) { create(:project_membership, :owner) }

      it { is_expected.to permit_actions(%i(destroy roller)) }
    end

    context "being the current pending user" do
      let(:membership) { create(:project_membership, :pending) }

      it { is_expected.to forbid_actions(%i(destroy roller)) }
      it { is_expected.to permit_actions(%i(show decider)) }
    end

    context "being a different pending user" do
      let(:project) { create(:project) }
      let(:membership) { create(:project_membership, :pending, project: project) }
      let(:another_membership) { create(:project_membership, :pending, project: project) }
      let(:user) { another_membership.user }

      it { is_expected.to forbid_actions(%i(show destroy decider roller)) }
    end

    context "being a different permanent member" do
      let(:project) { create(:project) }
      let(:membership) { create(:project_membership, project: project) }
      let(:another_membership) { create(:project_membership, project: project) }
      let(:user) { another_membership.user }

      it { is_expected.to forbid_actions(%i(show destroy decider roller)) }
    end

    context "being a permanent user" do
      it { is_expected.to permit_actions(%i(destroy)) }
      it { is_expected.to forbid_actions(%i(show decider roller)) }
    end

    context "being an uninvited user" do
      let(:user) { create(:user) }

      it { is_expected.to forbid_actions(%i(show destroy decider roller)) }
    end
  end
end
