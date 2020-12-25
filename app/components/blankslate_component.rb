class BlankslateComponent < ApplicationComponent
  attr_reader :title, :description

  def initialize(title:, description:)
    @title       = title
    @description = description
  end
end
