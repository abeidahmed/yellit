class Label < ApplicationRecord
  belongs_to :project

  before_validation :prepend_pound_symbol

  VALID_HEX_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i

  validates_presence_of :name, :color
  validates_length_of :name, maximum: 255
  validates_uniqueness_of :name, case_sensitive: false, scope: :project_id
  validates_format_of :color, with: VALID_HEX_REGEX, message: "is not a valid hex color code"

  def color
    self.text_color
  end

  def color=(value)
    self.text_color = value
    self.bg_color   = value
  end

  private
  def prepend_pound_symbol
    self.color = Chroma.get_hex_from(color) if color
  end
end
