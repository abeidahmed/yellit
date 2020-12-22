class Members::BaseComponent < ApplicationComponent
  attr_reader :member

  def initialize(member:)
    @member = member
  end

  def member_full_name
    member.full_name
  end

  def project_name
    member.project.name
  end
end