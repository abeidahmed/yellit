class Forms::ErrorDisplayComponent < ApplicationComponent
  attr_reader :error_type

  def initialize(error_type:)
    @error_type = error_type
  end
end
