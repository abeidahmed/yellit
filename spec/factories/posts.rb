FactoryBot.define do
  factory :post do
    project
    sequence(:title) { |n| "Version #{n}.0.0" }
    published_at { Time.zone.now - 1.hours }

    trait :draft do
      published_at { nil }
    end

    trait :scheduled do
      published_at { Time.zone.now + 2.hours }
    end
  end
end
