require "rails_helper"

RSpec.describe Section, type: :model do
  subject { build(:section) }

  describe "associations" do
    it { should belong_to(:post) }
  end

  describe "validations" do
    it { should validate_length_of(:body).is_at_most(5000) }
  end
end