module SignedIdHelper
  def invitation_sid_for(membership)
    membership.signed_id(purpose: :project_invitation)
  end
end