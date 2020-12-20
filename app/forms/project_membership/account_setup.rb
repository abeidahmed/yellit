class ProjectMembership::AccountSetup
  include ActiveModel::Model

  attr_accessor :full_name, :password, :id

  validates_presence_of :full_name
  validates_length_of :full_name, maximum: 255
  validates_length_of :password, minimum: User::MIN_PASSWORD_LENGTH

  def membership
    @membership ||= ProjectMembership.find_signed!(id)
  end

  def user
    @user ||= membership.user
  end

  def update
    if valid?
      user.update(full_name: full_name, password: password)
      true
    else
      false
    end
  end
end