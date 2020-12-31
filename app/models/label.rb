class Label < ApplicationRecord
  belongs_to :project
  has_many :taggables, dependent: :destroy
  has_many :sections, through: :taggables

  before_validation :normalize_hex_code

  VALID_HEX_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false, scope: :project_id } # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :color, format: { with: VALID_HEX_REGEX, message: "is not a valid hex code" }

  scope :sort_asc_by_name, -> { order(name: :asc) }

  def color
    bg_color
  end

  def color=(value)
    self.bg_color   = Chroma.get_hex_from(value)
    self.text_color = Chroma.get_accent_hex_from(value)
  end

  def self.search(query)
    if query.present?
      where("name iLIKE :query", query: "%#{query}%")
    else
      all
    end
  end

  private

  def normalize_hex_code
    self.color = Chroma.get_hex_from(color)
  end
end
