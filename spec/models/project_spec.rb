require "rails_helper"

RSpec.describe Project, type: :model do
  subject { build(:project) }

  describe "associations" do
    it { should have_many(:project_memberships) }

    it { should have_many(:users) }

    it { should have_many(:posts) }

    it { should have_many(:labels) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }

    it { should validate_length_of(:name).is_at_most(255) }

    it { should validate_length_of(:website_url).is_at_most(255) }

    it { should validate_presence_of(:subdomain) }

    it { should validate_length_of(:subdomain).is_at_most(63) }

    it { should validate_uniqueness_of(:subdomain).case_insensitive }

    it { should allow_value(
                  "http://gmail.com/",
                  "https://gmail.com/",
                  "https://domain.gmail.com",
                  "http://domain.gmail.com"
                ).for(:website_url) }

    it { should_not allow_value("http://gmail.com test", "https://gmail.com test").for(:website_url) }
  end

  describe "before save" do
    it "should lowercase website_url" do
      website_url = "https://google.com"
      project     = create(:project, website_url: website_url.upcase)
      expect(project.reload.website_url).to eq(website_url)
    end

    it "should lowercase subdomain" do
      subdomain = "helloworld"
      project   = create(:project, subdomain: subdomain.upcase)
      expect(project.reload.subdomain).to eq(subdomain)
    end
  end
end
