class CreateRoadmapHeaders < ActiveRecord::Migration[6.0]
  def change
    create_table :roadmap_headers do |t|
      t.references :user, null: false, foreign_key: true
      t.text :title
      t.text :assumption_level

      t.timestamps
    end
    add_index :roadmap_headers, [:user_id, :created_at]
  end
end
