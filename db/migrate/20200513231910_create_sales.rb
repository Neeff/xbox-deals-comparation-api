class CreateSales < ActiveRecord::Migration[6.0]
  def change
    enable_extension :pg_trgm
    create_table :sales do |t|
      t.string :status
      t.string :name_game
      t.string :old_price
      t.string :new_price
      t.string :link_to_xbox_site
      t.timestamps
      t.index :name_game, opclass: :gin_trgm_ops, using: :gin
    end
  end
end
