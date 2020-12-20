class Members::InfoComponent < ApplicationComponent
  attr_reader :member, :project

  def initialize(member:)
    @member  = member
    @project = member.project
  end

  def full_name
    pending_member? ? "Invitation pending" : member.full_name
  end

  def member_role
    member.role.capitalize
  end

  def name_classes
    pending_member? ? "f5 text-gray" : "h5"
  end

  private
  def pending_member?
    member.project_invite_pending?(project)
  end
end
