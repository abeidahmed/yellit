class PageHeads::WithActionComponent < ApplicationComponent
  attr_reader :project

  def initialize(project:)
    @project = project
  end

  def project_name
    project.name
  end
end
