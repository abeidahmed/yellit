class Section < ApplicationRecord
  belongs_to :post
  has_many :taggables, dependent: :destroy
  has_many :labels, through: :taggables

  validates :body, length: { maximum: 5000 }
end
