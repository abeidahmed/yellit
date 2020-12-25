require "rails_helper"

RSpec.describe "App::Labels", type: :request do
  describe "#create" do
    it "should create the label" do
      project = initialize_request
      post app_project_labels_path(project), params: { label: attributes_for(:label) }

      expect(project.labels.count).to eq(1)
    end

    it "should return error if label is invalid" do
      post app_project_labels_path(initialize_request), params: { label: attributes_for(:label).except(:name) }

      expect(json.dig(:errors, :name)).to be_present
    end
  end

  def initialize_request
    membership = create(:project_membership)
    project    = membership.project
    login(membership.user)
    project
  end
end
