class Post < ApplicationRecord
  belongs_to :project
  has_many :sections, inverse_of: :post

  before_save :check_draft_status

  validates_presence_of :title

  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  scope :scheduled, -> { where.not(published_at: nil).where("published_at > ?", Time.zone.now) }

  attr_accessor :draft

  private
  def check_draft_status
    self.published_at = nil if draft == 1
  end
end
