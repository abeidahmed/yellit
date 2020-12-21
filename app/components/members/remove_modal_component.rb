class Members::RemoveModalComponent < ApplicationComponent
  with_content_areas :trigger

  attr_reader :member

  def initialize(member:)
    @member = member
  end

  def member_full_name
    member.full_name
  end
end
