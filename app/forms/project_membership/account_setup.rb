class ProjectMembership::AccountSetup
  include ActiveModel::Model

  attr_accessor :full_name, :password, :id

  validates_presence_of :full_name
  validates_length_of :full_name, maximum: 255
  validates_length_of :password, minimum: User::MIN_PASSWORD_LENGTH
  validate :full_name_is_not_reserved

  def membership
    @membership ||= ProjectMembership.find_signed!(id, purpose: :project_invitation)
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

  private
  def full_name_is_not_reserved
    errors.add(:full_name, "can't be #{full_name}") if full_name_invalid?
  end

  def full_name_invalid?
    User::FULL_NAME_EXCLUSION.include? full_name.to_s.strip.downcase
  end
end