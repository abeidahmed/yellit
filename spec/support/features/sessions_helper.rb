module Features
  module SessionsHelper
    def sign_up(full_name: "John Doe", email_address: "hello@exa.com", password: "secrettt")
      visit new_user_path
      fill_in "user[full_name]", with: "John Doe"
      fill_in "user[email_address]", with: "hello@example.com"
      fill_in "user[password]", with: "secrettt"
      click_button "Sign up"
    end

    def sign_in(user: nil)
      user = user || create(:user)
      visit new_session_path
      fill_in "email_address", with: user.email_address
      fill_in "password", with: user.password
      click_button "Sign"
    end
  end
end