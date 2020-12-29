class CreateTaggables < ActiveRecord::Migration[6.1]
  def change
    create_table :taggables, id: :uuid do |t|
      t.references :section, null: false, foreign_key: true, type: :uuid
      t.references :label, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
