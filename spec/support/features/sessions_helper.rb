module Features
  module SessionsHelper
    def sign_in(user: nil)
      user = user || create(:user)
      visit new_session_path
      fill_in "email_address", with: user.email_address
      fill_in "password", with: user.password
      click_button "Sign"
    end
  end
end