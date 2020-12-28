require "rails_helper"

RSpec.describe "App::Posts", type: :request do
  describe "#update" do
    let(:membership) { create(:project_membership) }
    let(:project) { membership.project }
    let(:post) { create(:post, project: project) }

    before { login(membership.user) }

    it "should update the post to draft mode if fields are valid" do
      patch app_post_path(post), params: {
        post: {
          title: "Test post",
          draft: 1,
          published_at: Time.zone.now,
          sections_attributes: [
            { body: "Hello world" },
            { body: "Another body" }
          ]
        }
      }

      post.reload
      expect(post.title).to eq("Test post")
      expect(post.published_at).to be_nil
      expect(post.sections.first.body).to eq("Hello world")
      expect(post.sections.last.body).to eq("Another body")
    end

    it "should update the post to user defined time" do
      patch app_post_path(post), params: { post: { title: "Test post", draft: 0, published_at: Time.zone.now } }

      post.reload
      expect(post.title).to eq("Test post")
      expect(post.published_at).to be_present
    end

    it "should not create the section when section body is blank" do
      patch app_post_path(post), params: { post: { title: "Test post", sections_attributes: [{ body: "" }] } }

      post.reload
      expect { Section.find(post.sections.first) }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should throw error if fields are invalid" do
      patch app_post_path(post), params: { post: { title: "" } }

      expect(json[:errors]).to_not be_nil
    end
  end
end
