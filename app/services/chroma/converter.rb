module Chroma
  class Converter
    def initialize(hex)
      @hex = hex
    end

    def to_rgb
      hex.scan(/.{2}/).map { |color| color.to_i(16) }
    end

    private
    attr_reader :hex
  end
end