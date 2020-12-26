class Labels::DeleteModalComponent < ApplicationComponent
  with_content_areas :trigger

  attr_reader :label

  def initialize(label:)
    @label = label
  end

  def label_name
    label.name
  end
end
