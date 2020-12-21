class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :full_name, :email_address, :project_invite_pending?, :project_owner?, to: :user

  enum role: { member: "member", owner: "owner" }

  scope :users_with_role, ->(role) { where(role: role) }

  validates_uniqueness_of :user, case_sensitive: false, scope: :project_id, message: "is already on the project team"

  def self.humanized_role_keys
    roles.map { |key, value| [key.humanize, key] }
  end
end
