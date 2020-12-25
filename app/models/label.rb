class Label < ApplicationRecord
  belongs_to :project

  before_validation :normalize_hex_code

  VALID_HEX_REGEX = /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/i

  validates_presence_of :name
  validates_length_of :name, maximum: 255
  validates_uniqueness_of :name, case_sensitive: false, scope: :project_id
  validates_format_of :text_color, :bg_color, with: VALID_HEX_REGEX, message: "is not a valid hex color code"

  private
  def normalize_hex_code
    self.text_color = prefix_hash(self.text_color)
    self.bg_color = prefix_hash(self.bg_color)
  end

  def prefix_hash(hex_code)
    hex_code.chr == "#" ? hex_code : "##{hex_code}"
  end
end
