class Taggable < ApplicationRecord
  belongs_to :section
  belongs_to :label
end
