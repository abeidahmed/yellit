class Post < ApplicationRecord
  belongs_to :project

  validates_presence_of :title

  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  scope :scheduled, -> { where.not(published_at: nil).where("published_at > ?", Time.zone.now) }
end
