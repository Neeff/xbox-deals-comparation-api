class CreateDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :details do |t|
      t.references :sale, null: true, foreign_key: true
      t.string :banner
      t.text :description
      t.string :clasification_image
      t.string :clasification
      t.string :c_category
      t.timestamps
    end
  end
end
