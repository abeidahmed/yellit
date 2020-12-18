require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "#create" do
    it "should sign-in user when request is valid" do
      user = create(:user)
      post sessions_path, params: { email_address: user.email_address, password: user.password }

      expect(cookies[:auth_token]).to eq(user.auth_token)
    end

    it "should return error when sign-in is invalid" do
      user = create(:user)
      post sessions_path, params: { email_address: "hello@ex.com", password: user.password }

      expect(json.dig(:errors, :invalid)).to be_present
    end
  end
end
