require "rails_helper"

RSpec.describe "App::Projects", type: :request do
  describe "#update" do
    let(:membership) { create(:project_membership, :owner) }
    let(:project) { membership.project }
    before { login(membership.user) }

    it "should update the project" do
      patch app_project_path(project), params: { project: { name: "Hello", website_url: project.website_url, subdomain: project.subdomain } }

      expect(project.reload.name).to eq("Hello")
    end

    it "should return error if project is invalid" do
      patch app_project_path(project), params: { project: { name: "", website_url: project.website_url, subdomain: project.subdomain } }

      expect(json.dig(:errors, :name)).to be_present
    end
  end
end
