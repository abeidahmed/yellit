class Post < ApplicationRecord
  belongs_to :project
  has_many :sections, inverse_of: :post, dependent: :destroy

  accepts_nested_attributes_for :sections, reject_if: :body_is_blank?, allow_destroy: true

  before_save :check_draft_status

  validates :title, presence: true

  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.zone.now) }
  scope :scheduled, -> { where.not(published_at: nil).where("published_at > ?", Time.zone.now) }

  attr_accessor :draft

  private

  def check_draft_status
    self.published_at = nil if draft.to_i == 1
  end

  def body_is_blank?(attributes)
    attributes[:body].blank?
  end
end
