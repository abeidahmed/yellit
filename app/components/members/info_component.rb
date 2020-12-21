class Members::InfoComponent < Members::BaseComponent
  def project
    member.project
  end

  def member_full_name
    pending_member? ? "Invitation pending" : super
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
