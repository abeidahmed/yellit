FactoryBot.define do
  factory :user do
    full_name { "John Doe" }
    sequence(:email_address) { |n| "johndoe#{n}@example.com" }
    password { "passwordsecret" }
    auth_token { "helloworld" }
  end
end
