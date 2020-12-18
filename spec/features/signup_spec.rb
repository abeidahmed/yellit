require "rails_helper"

RSpec.feature "Signups", type: :feature do
  it "should redirect me to home page after successfully signing up" do
    visit new_user_path
    fill_in "user[full_name]", with: "John Doe"
    fill_in "user[email_address]", with: "hello@example.com"
    fill_in "user[password]", with: "secrettt"
    click_button "Create account"

    expect(current_path).to eq(root_path)
  end

  # it "should take me to sign in page if I click on the sign in link" do
  #   visit new_user_path
  #   click_link "Sign in"

  #   expect(current_path).to eq(new_session_path)
  # end
end
