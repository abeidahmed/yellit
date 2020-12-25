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

  describe "#update" do
    it "should update the label" do
      label = create(:label, project: initialize_request)
      patch app_label_path(label), params: { label: { name: "Updated label", bg_color: "#ffffff", text_color: "#000000" } }

      label.reload
      expect(label.name).to eq("Updated label")
      expect(label.bg_color).to eq("#ffffff")
      expect(label.text_color).to eq("#000000")
    end

    it "should return error when update is invalid" do
      label = create(:label, project: initialize_request)
      patch app_label_path(label), params: { label: { name: "", bg_color: "#ffffff", text_color: "#000000" } }

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
