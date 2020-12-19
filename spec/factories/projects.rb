FactoryBot.define do
  factory :project do
    name { "Project name" }
    website_url { "https://goodquality.com" }
    sequence(:subdomain) { |n| "sub#{n}" }
  end
end
