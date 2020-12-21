class Members::ExitModalComponent < ApplicationComponent
  with_content_areas :trigger

  attr_reader :member

  def initialize(member:)
    @member = member
  end

  def project_name
    member.project.name
  end
end
