class Label < ApplicationRecord
  belongs_to :project

  before_validation :normalize_hex_code

  VALID_HEX_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i

  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_uniqueness_of :name, case_sensitive: false, scope: :project_id
  validates_format_of :color, with: VALID_HEX_REGEX, message: "is not a valid hex color code"

  def color
    self.bg_color
  end

  def color=(value)
    self.bg_color   = Chroma.get_hex_from(value)
    self.text_color = Chroma.get_accent_hex_from(value)
  end

  private
  def normalize_hex_code
    self.color = Chroma.get_hex_from(color)
  end
end
