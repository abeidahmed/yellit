require "rails_helper"

RSpec.describe Taggable, type: :model do
  it { should belong_to(:section) }

  it { should belong_to(:label) }
end
