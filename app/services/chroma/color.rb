module Chroma
  class Color
    include ActiveModel::Model

    attr_reader :hex

    def initialize(hex)
      @hex = hex
    end

    def complement
      Duo.new(normalized_hex).complement
    end

    def standardized_hex
      "##{normalized_hex}"
    end

    private
    def normalized_hex
      begin
        if [3, 4].include?(hex.size)
          reduced_or_original_hex.split("").map { |v| v * 2 }.join
        else
          reduced_or_original_hex
        end
      rescue => exception
        errors.add(:color, "must be 3 or 6 characters in length")
      end
    end

    def reduced_or_original_hex
      hex.chr == "#" ? hex.slice(1..-1) : hex
    end
  end
end