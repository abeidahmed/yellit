require "rails_helper"

RSpec.describe ProjectMembership, type: :model do
  subject { build(:project_membership) }

  describe "associations" do
    it { should belong_to(:user) }

    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:user).
      scoped_to(:project_id).
      case_insensitive.
      with_message("is already on the project team")
    }

    it { should define_enum_for(:role).
      with_values(member: "member", owner: "owner").
      backed_by_column_of_type(:string)
    }
  end
end
