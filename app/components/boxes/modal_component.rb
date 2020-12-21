class Boxes::ModalComponent < ApplicationComponent
  with_content_areas :body, :footer, :trigger

  attr_reader :title

  def initialize(title: nil)
    @title = title
  end
end
