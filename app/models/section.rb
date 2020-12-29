class Section < ApplicationRecord
  belongs_to :post
  has_many :taggables
  has_many :labels, through: :taggables

  validates_length_of :body, maximum: 5000
end
