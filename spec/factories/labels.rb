FactoryBot.define do
  factory :label do
    name { "Fixes" }
    bg_color { "#f6f8fa" }
    text_color { "#24292e" }
    project
  end
end
