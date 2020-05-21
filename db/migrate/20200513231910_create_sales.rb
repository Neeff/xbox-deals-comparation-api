class CreateSales < ActiveRecord::Migration[6.0]
  def change
    create_table :sales do |t|
      t.string :status
      t.string :name_game
      t.string :old_price
      t.string :new_price
      t.string :link_to_xbox_site
      t.string :region

      t.timestamps
    end
  end
end
