class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string     :name,        null: false, default: ""
      t.string     :website_url
      t.string     :subdomain,   null: false, default: ""

      t.timestamps
    end
    add_index :projects, :subdomain
  end
end
