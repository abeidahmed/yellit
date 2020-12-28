class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.string     :title,        null: false
      t.datetime   :published_at
      t.references :project,      null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :posts, :published_at
  end
end
