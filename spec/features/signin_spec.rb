require "rails_helper"

RSpec.feature "Signins", type: :feature do
  it "should sign-in user when email and password is valid" do
    sign_in

    expect(current_path).to eq(root_path)
  end

  it "should take me to sign-up page when I click on Sign up link" do
    visit new_session_path
    click_link "Sign up"

    expect(current_path).to eq(new_user_path)
  end
end
