class ProjectMembership::Invitation
  include ActiveModel::Model

  attr_accessor :email_address, :role, :project

  validates_presence_of :email_address
  validates_length_of :email_address, maximum: 255
  validates_format_of :email_address, with: User::VALID_EMAIL_REGEX
  validate :member_uniqueness

  def self.model_name
    ActiveModel::Name.new(self, nil, "User")
  end

  def user
    @user ||= User.create_with(
      full_name: "Anonymous",
      password:  SecureRandom.urlsafe_base64
    ).find_or_initialize_by(email_address: user_email_address)
  end

  def invited
    if valid?
      if user.persisted?
        add_user_to_project_team
        send_invitation
      else
        add_user_to_project_team
        send_invitation(new_user: true)
      end
      true
    else
      false
    end
  end

  private
  def send_invitation(new_user: false)
    ProjectMailer.project_invitation(membership, new_user: new_user).deliver
  end

  def add_user_to_project_team
    Project::AddMember.new(user: user, project: project, role: user_role, invited: true)
  end

  def membership
    user.find_project_membership(project)
  end

  def user_role
    role || "member"
  end

  def member_uniqueness
    errors.add(:email_address, "is already registered on the team") if project.project_memberships.exists?(user_id: user.id)
  end

  def user_email_address
    email_address.downcase
  end
end