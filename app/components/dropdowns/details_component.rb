class Dropdowns::DetailsComponent < ApplicationComponent
  with_content_areas :body

  attr_reader :button_title, :title, :position

  def initialize(button_title:, title: nil, position: "right")
    @button_title = button_title
    @title       = title
    @position    = position
  end

  def dropdown_position
    case position
    when "right"
      "right-0"
    when "left"
      ""
    else
      raise "Undefined position: #{position}"
    end
  end
end
