FactoryBot.define do
  factory :project_membership do
    project
    user
    join_date { "2020-11-23 09:33:17" }
    role { "member" }

    trait :pending do
      join_date { nil }
    end

    trait :owner do
      role { "owner" }
    end

    trait :pending_owner do
      pending
      owner
    end
  end
end
