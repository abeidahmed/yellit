class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :full_name, :email_address, to: :user

  enum role: { member: "member", owner: "owner" }

  scope :users_with_role, ->(role) { where(role: role) }

  validates_uniqueness_of :user, case_sensitive: false, scope: :project_id, message: "is already on the project team"
end
