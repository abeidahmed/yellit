class CreateProjectMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :project_memberships, id: :uuid do |t|
      t.datetime    :join_date
      t.string      :role,     null: false, default: "member"
      t.references  :project,  null: false, foreign_key: true, type: :uuid
      t.references  :user,     null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :project_memberships, [:join_date, :role]
  end
end
