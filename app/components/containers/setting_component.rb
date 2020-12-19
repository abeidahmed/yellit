class Containers::SettingComponent < ApplicationComponent
  with_content_areas :body

  attr_reader :project

  def initialize(project:)
    @project = project
  end
end
