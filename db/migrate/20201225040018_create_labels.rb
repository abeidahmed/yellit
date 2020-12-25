class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels, id: :uuid do |t|
      t.string     :name,       null: false
      t.string     :bg_color,   null: false, default: "#0e8a16"
      t.string     :text_color, null: false, default: "#ffffff"
      t.references :project,    null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :labels, :name
  end
end
