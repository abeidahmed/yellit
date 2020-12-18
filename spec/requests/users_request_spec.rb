require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "#create" do
    it "should register the user if sign up is valid" do
      post users_path, params: { user: { full_name: "John Doe", email_address: "hello@example.com", password: "secretttt" } }

      expect(User.count).to eq(1)
      expect(cookies[:auth_token]).to eq(User.first.auth_token)
    end

    it "should return error if sign up is invalid" do
      post users_path, params: { user: { full_name: "John Doe", email_address: "", password: "secretttt" } }

      expect(json.dig(:errors, :email_address)).to be_present
    end
  end
end
