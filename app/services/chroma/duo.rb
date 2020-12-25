module Chroma
  class Duo
    WHITE = "#ffffff"
    BLACK = "#000000"

    def initialize(hex)
      @hex = hex
    end

    def complement
      contrast_of(*rgb_array) >= 128 ? BLACK : WHITE
    end

    private
    attr_reader :hex

    def rgb_array
      Converter.new(hex).to_rgb
    end

    def contrast_of(r, g, b)
      (r * 299 + g * 587 + b * 114) / 1000
    end
  end
end