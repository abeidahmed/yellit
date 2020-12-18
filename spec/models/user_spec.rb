require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should have_secure_password }

    it { should validate_presence_of(:email_address) }

    it { should validate_uniqueness_of(:email_address).case_insensitive }

    it { should_not allow_value("abeidmama", "abeidm@em@.com").for(:email_address) }

    it { should allow_value("abeidmama@example.com", "abeidm@em.uk.com").for(:email_address) }

    it { should validate_length_of(:email_address).is_at_most(255) }

    it { should validate_presence_of(:full_name) }

    it { should validate_length_of(:full_name).is_at_most(255) }

    it "is should lowercase email_address before saving" do
      subject.email_address = subject.email_address.upcase
      subject.save!
      expect(subject.reload.email_address).to eq(subject.email_address.downcase)
    end

    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "before creating a new user" do
    it "is should set auth_token with Secure Random hash" do
      subject.auth_token = nil
      subject.save!
      expect(subject.reload.auth_token).to_not be_nil
    end

    it "should trim excess white spaces" do
      subject.email_address = "       email@example.com "
      subject.save!
      expect(subject.email_address).to eq("email@example.com")
    end
  end
end
