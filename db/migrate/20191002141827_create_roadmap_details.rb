class CreateRoadmapDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :roadmap_details do |t|
      t.references :roadmap_header, null: false, foreign_key: true
      t.text :sub_title
      t.text :pic_pass1
      t.text :pic_pass2
      t.text :pic_pass3
      t.text :pic_pass4
      t.integer :time_required
      t.integer :time_required_unit
      t.text :content

      t.timestamps
    end
  end
end
