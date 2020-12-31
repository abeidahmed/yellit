class ProjectMembership < ApplicationRecord
  belongs_to :project
  belongs_to :user

  delegate :full_name, :email_address, :project_invite_pending?, :project_owner?, to: :user

  enum role: { member: "member", owner: "owner" }

  scope :users_with_role, ->(role) { where(role: role) }

  validates :user, uniqueness: { case_sensitive: false, scope: :project_id, message: "is already on the project team" } # rubocop:disable Rails/UniqueValidationWithoutIndex

  def self.humanized_role_keys
    roles.map { |key, _value| [key.humanize, key] }
  end

  def self.search(query)
    if query.present?
      where("users.email_address iLIKE :query OR users.full_name iLIKE :query", query: "%#{query}%").references(:users)
    else
      all
    end
  end

  def self.filter_by_role(role)
    if role.present?
      if role.downcase == "pending"
        where(join_date: nil)
      else
        users_with_role(role.downcase)
      end
    else
      all
    end
  end
end
