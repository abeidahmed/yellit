class Project::AddMember
  def initialize(project:, user:, role: "member", invited: false)
    @project   = project
    @user      = user
    @invited   = invited
    @role      = role
  end

  def self.new(**arguments, &block)
    super
    super.add_user_to_team
  end

  def add_user_to_team
    project.project_memberships.create!(
      user:      user,
      role:      role.to_s.downcase,
      join_date: invited ? nil : Time.zone.now
    )
  end

  private
  attr_reader :project, :user, :invited, :role
end