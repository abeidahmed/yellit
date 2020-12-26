require "rails_helper"

RSpec.describe "App::Labels", type: :request do
  describe "#create" do
    it "should create the label" do
      project = initialize_request
      post app_project_labels_path(project), params: { label: { name: "New label", color: "#ffffff" } }

      label = project.labels.first
      expect(label.name).to eq("New label")
      expect(label.text_color).to eq("#000000")
      expect(label.bg_color).to eq("#ffffff")
    end

    it "should return error if label is invalid" do
      post app_project_labels_path(initialize_request), params: { label: attributes_for(:label).except(:name) }

      expect(json.dig(:errors, :name)).to be_present
    end
  end

  describe "#update" do
    it "should update the label" do
      label = create(:label, project: initialize_request)
      patch app_label_path(label), params: { label: { name: "Updated label", color: "#ffffff" } }

      label.reload
      expect(label.name).to eq("Updated label")
      expect(label.text_color).to eq("#000000")
      expect(label.bg_color).to eq("#ffffff")
    end

    it "should return error when update is invalid" do
      label = create(:label, project: initialize_request)
      patch app_label_path(label), params: { label: { name: "", color: "#ffffff" } }

      expect(json.dig(:errors, :name)).to be_present
    end
  end

  describe "#destroy" do
    it "should delete the label" do
      label = create(:label, project: initialize_request)
      delete app_label_path(label)

      expect { Label.find(label.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  def initialize_request
    membership = create(:project_membership)
    project    = membership.project
    login(membership.user)
    project
  end
end
