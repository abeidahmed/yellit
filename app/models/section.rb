class Section < ApplicationRecord
  belongs_to :post

  validates_length_of :body, maximum: 5000
end
