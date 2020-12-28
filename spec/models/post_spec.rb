require "rails_helper"

RSpec.describe Post, type: :model do
  subject { build(:post) }

  describe "associations" do
    it { should belong_to(:project) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
  end

  describe "::draft" do
    it "should get all the draft posts only" do
      draft     = create(:post, :draft)
      published = create(:post)
      scheduled = create(:post, :scheduled)

      expect(Post.draft.map(&:title)).to match_array(draft.title)
    end
  end

  describe "::published" do
    it "should get all the published posts only" do
      draft     = create(:post, :draft)
      published = create(:post)
      scheduled = create(:post, :scheduled)

      expect(Post.published.map(&:title)).to match_array(published.title)
    end
  end

  describe "::scheduled" do
    it "should get all the scheduled posts only" do
      draft     = create(:post, :draft)
      published = create(:post)
      scheduled = create(:post, :scheduled)

      expect(Post.scheduled.map(&:title)).to match_array(scheduled.title)
    end
  end
end
