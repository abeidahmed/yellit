module Chroma
  def self.get_hex_from(hex_code)
    Color.new(hex_code).standardized_hex
  end

  def self.get_accent_hex_from(hex_code)
    Color.new(hex_code).complement
  end
end