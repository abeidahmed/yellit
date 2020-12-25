require "rails_helper"

RSpec.describe Label, type: :model do
  subject { build(:label) }

  describe "associations" do
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name).scoped_to(:project_id).case_insensitive }

    it { should validate_length_of(:name).is_at_most(255) }

    it { should allow_value("#000", "#1f1f1F", "1f1f1F").for(:text_color) }

    it { should allow_value("#000", "#1f1f1F", "1f1f1F").for(:bg_color) }

    it { should_not allow_value("#F0h", "#afaf", "1f1#1F", "0000").for(:text_color) }

    it { should_not allow_value("#F0h", "#afaf", "1f1#1F", "0000").for(:bg_color) }
  end
end
